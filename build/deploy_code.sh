echo "Coverting source to metadata format"
sfdx force:source:convert -d deploy_code -r force-app

echo "Deploying code to org"
sfdx force:mdapi:deploy -u DevHub -d deploy_code/ -w -1 -l RunLocalTests