echo "Setting up DevHub Connection..."
mkdir appKeys
echo $CERT_KEY | base64 -di > appKeys/server.key

# Authenticate to salesforce
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $APP_KEY --jwtkeyfile appKeys/server.key --username $SF_USERNAME --setdefaultdevhubusername -a DevHub

#Create a scratch org
echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s

sfdx force:source:push -u ${CIRCLE_BRANCH}
sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --resultformat tap --targetusername ${CIRCLE_BRANCH}