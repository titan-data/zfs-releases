package main

import (
	"context"
	"encoding/json"
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

func main(){
	releases, _, err := client.Repositories.ListReleases(ctx, "actions", "virtual-environments", &github.ListOptions{PerPage: 50})
	if err != nil {
		return
	}
	for _, release := range releases {
		if strings.Contains(release.GetTagName(), "ubuntu18") {
			for _, line := range strings.Split(release.GetBody(), "\r\n") {
				if strings.Contains(line, "Linux kernel version:") {
					kernels = append(kernels, strings.TrimPrefix(line, "- Linux kernel version: "))
				}
			}
		}
	}
	kernels, err := json.Marshal(kernels)
	fmt.Println(string(kernels))
}