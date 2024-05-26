#!/bin/bash

# 獲取當前目錄下所有以 .md 結尾的文件
md_files=$(find ./_posts/zmediumtomarkdown/ -type f -name "*.md")

# 執行 chatgpt-md-translator 命令對每個文件
for file in $md_files; 
do 
  chatgpt-md-translator "$file"
done