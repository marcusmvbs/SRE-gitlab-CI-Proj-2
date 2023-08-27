provider "google" {
   credentials = "${file("../creds/service_account.json")}"
   project     = "pioneering-rex-394919" 
   region      = "us-central1"
 }