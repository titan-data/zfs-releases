package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"github.com/google/go-github/v39/github"
	"golang.org/x/oauth2"
	"os"
	"strings"
)

var client *github.Client
var ctx = context.Background()

func init() {
	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: os.Getenv("GITHUB_PAT")},
	)
	tc := oauth2.NewClient(ctx, ts)
	client = github.NewClient(tc)
}

var kernels []string

func main() {
	var linuxVariant string
	flag.StringVar(&linuxVariant, "l", "linuxVariant", "specify linux variant")
	flag.Parse()
	releases, _, err := client.Repositories.ListReleases(ctx, "actions", "runner-images", &github.ListOptions{PerPage: 100})
	if err != nil {
		return
	}
	for _, release := range releases {
		if strings.Contains(linuxVariant, ",") {
			lv := strings.Split(linuxVariant, ",")
			for _, v := range lv {
				if strings.Contains(release.GetTagName(), v) {
					for _, line := range strings.Split(release.GetBody(), "\r\n") {
						if strings.Contains(line, "Linux kernel version:") {
							kernels = append(kernels, strings.TrimPrefix(line, "- Linux kernel version: "))
						}
						if strings.Contains(line, "Kernel Version:") {
							kernels = append(kernels, strings.TrimPrefix(line, "- Kernel Version: "))
						}
					}
				}
			}
		} else {
			if strings.Contains(release.GetTagName(), linuxVariant) {
				for _, line := range strings.Split(release.GetBody(), "\r\n") {
					if strings.Contains(line, "Linux kernel version:") {
						kernels = append(kernels, strings.TrimPrefix(line, "- Linux kernel version: "))
					}
				}
			}
		}
	}
	kernels = dedupe(kernels)
	kernels, err := json.Marshal(kernels)
	fmt.Println(string(kernels))
}

// https://go.dev/play/p/iyb97KcftMa
func dedupe(strSlice []string) []string {
	allKeys := make(map[string]bool)
	list := []string{}
	for _, item := range strSlice {
		if _, value := allKeys[item]; !value {
			allKeys[item] = true
			list = append(list, item)
		}
	}
	return list
}
