#!/bin/bash

# Define the Wolfram Alpha API endpoint and app ID
WOLFRAM_ENDPOINT="https://api.wolframalpha.com/v2/query"
WOLFRAM_APPID="8295KP-JVKJT597TL"

# Create the logs directory if it doesn't exist
LOGS_DIR="wolfram/logs"
mkdir -p "$LOGS_DIR"

# Get the current timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Get the query from the command line argument
QUERY="$1"
QUERY=$(echo $QUERY | awk '{$1=$1};1')
echo "QUERY: $QUERY" >> "$LOGS_DIR/$TIMESTAMP.txt"
QUERY=${QUERY// /%20}
QUERY=${QUERY//\?/%3F}


# Call the Wolfram Alpha API and log the response
RESPONSE=$(curl -s "$WOLFRAM_ENDPOINT?appid=$WOLFRAM_APPID&input=$QUERY")

# Check if the query was successful
if echo "$RESPONSE" | grep -q '<queryresult success="false"'; then
  echo "Sorry, the query was not successful."
  exit 1
fi

# Extract the answer in plaintext from the response
ANSWER=$(echo "$RESPONSE" | xmllint --xpath "//pod[@primary='true']/subpod/plaintext/text()" -)
echo $ANSWER

# LOGS
echo "ANSWER: $ANSWER" >> "$LOGS_DIR/$TIMESTAMP.txt"
echo "RESPONSE: $RESPONSE" >> "$LOGS_DIR/$TIMESTAMP.txt"



# TODO <<Extract the image links from the response and log them>>

# IMGLINKS=$(echo "$RESPONSE" | tr '\n' ' ' | sed -n 's/.*<img src="\(.*\)"\/>.*/\1/p')
# echo "Image links:" >> "$LOGS_DIR/$TIMESTAMP.txt"
# echo "$IMGLINKS" >> "$LOGS_DIR/$TIMESTAMP.txt"

# Display the images using feh, if available
# if command -v feh >/dev/null 2>&1; then
#   echo "$IMGLINKS" | xargs -I {} sh -c 'curl -s {} | feh -'
# else
#   echo "feh is not installed, skipping image display."
# fi