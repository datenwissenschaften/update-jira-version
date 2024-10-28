FROM ubuntu:latest

# Install necessary dependencies
# RUN apt-get update && apt-get install -y jq git curl

# Copy the action script
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Set the entry point for the action
ENTRYPOINT ["/entrypoint.sh"]