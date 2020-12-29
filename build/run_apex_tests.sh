echo "Coverting source to metadata format"
sfdx force:source:convert -d test_code -r force-app

echo "Deploying code to org"
sfdx force:mdapi:deploy --checkonly -u DevHub -d test_code/ -w -1 -l RunLocalTests