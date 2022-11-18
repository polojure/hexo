#!/usr/bin/env sh
hexo deploy
git add .
git commit -m 'test'
git push