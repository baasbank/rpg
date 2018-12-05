#!/bin/bash

add_gcloud_apt_repository() {
  apt-get update
  apt-get install sudo curl -y
# Create an environment variable for the correct distribution
  export CLOUD_SDK_REPO="cloud-sdk-xenial"

# Add the Cloud SDK distribution URI as a package source
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
}

# Update the package list and install the Cloud SDK
install_gcloud() {
  sudo apt-get update
  sudo apt-get install google-cloud-sdk=180.0.1-0 -y
}

# Decode gcloud service key
write_gcloud_service_key() {
  echo $GCLOUD_SERVICE_KEY > ${HOME}/gcloud-service-key.json
}

# Authenticate gcloud and set a default project
set_up_gcloud_project() {
  gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
  gcloud config set project $GCLOUD_PROJECT
}

#Deploy change
deploy_change() {
  gcloud compute project-info add-metadata --metadata image_name=${DOCKER_LOGIN}/$IMAGE_NAME:$TAG
  gcloud beta compute instance-groups managed rolling-action replace  $INSTANCE_GROUP_NAME --max-surge=$MAX_SURGE --max-unavailable=$MAX_UNAVAILABLE --min-ready=200 --zone=$ZONE
}


main() {
  add_gcloud_apt_repository
  install_gcloud
  write_gcloud_service_key
  set_up_gcloud_project
  deploy_change
}
main
