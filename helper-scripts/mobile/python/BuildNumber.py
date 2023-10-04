import json
import Oauth

appId="1:844451946578:android:e4590f627259f1872a3f8b"
projectNumber="844451946578"


# Use the service object 'fbdist' to call the REST API methods defined https://firebase.google.com/docs/reference/app-distribution/rest/v1/projects.apps.releases/list and retrieve the response.

response = (
    Oauth.fbdist.projects()
    .apps()
    .releases()
    .list(parent=f"projects/{projectNumber}/apps/{appId}")
    .execute()
)


# Response has the schema of an object ( dictionary formed of key:value pairs where value = string / list / dict / etc).
# The data will be in descending order, that's why use the index 0 for the first object from the releases[] array to retrieve the latest build number.
latestBuildNumber=response["releases"][0]["buildVersion"]
nextBuildNumber=int(latestBuildNumber)+1

print(nextBuildNumber)