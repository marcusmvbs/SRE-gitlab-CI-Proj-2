apk update
apk add --no-cache gnupg python3 python3-dev py3-pip ansible curl wget
pip3 --no-cache-dir install google-auth google-auth-httplib2 google-auth-oauthlib
ansible-galaxy collection install kubernetes.core

mkdir -p ./creds
echo $serviceaccount | base64 -d > ./creds/service_account.json

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-443.0.0-linux-x86_64.tar.gz
tar -xzf google-cloud-cli-443.0.0-linux-x86_64.tar.gz -C /usr/local/
ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud # folder link

gcloud components install kubectl
gcloud components update
gcloud config set core/disable_usage_reporting true
gcloud config set component_manager/disable_update_check true
gcloud --version
gcloud auth activate-service-account --key-file=./creds/service_account.json

echo 'export PATH=$PATH:/usr/local/google-cloud-sdk/bin' >> /etc/profile
source /etc/profile