#!/bin/bash

# Script for incrementing the chart version.
VERSION_FILE=".chart_version"
Chart_file="app_chart/Chart.yaml"

current_version=$(awk '{print $0}' "$VERSION_FILE")

IFS='.' read -ra current_version_array <<< "$current_version"

current_version_array[1]=$((current_version_array[1] + 1))

new_version=$(IFS='.'; echo "${current_version_array[*]}")

echo "$new_version" > "$VERSION_FILE"

awk -v new_version="$new_version" '/^version:/ {$2 = new_version} 1' $Chart_file > Chart.yaml.tmp && mv Chart.yaml.tmp $Chart_file

echo "$new_version"

