#!/bin/sh

for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

if yesno "Replace crontab with 'crontab' file in this folder?" Y; then
  # This will replace the current crontab file with this crontab file
  crontab ./crontab
else
  echo "You NOPED out."
  exit 1;
fi

echo "Replacement complete!"
echo "you can see the active cronjobs with crontab -l."

