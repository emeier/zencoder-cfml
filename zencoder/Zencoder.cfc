<cfcomponent output="false">

    <!--- constructor --->
    <cffunction name="init" output="false">
        <cfargument name="apiKey" type="string" required="true" />

        <cfset variables.apiKey = arguments.apiKey />
        <cfset variables.apiEndpoint = "https://app.zencoder.com/api/v2/" />

        <cfreturn this />
    </cffunction>

    <!--- public methods --->
    <cffunction name="getMinutesUsed" output="false">
        <cfset var theUrl = variables.apiEndpoint & "reports/minutes" />
        <cfset var rawResponse = sendRequest(theUrl, "get") />
        <cfset var response = {} />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <!--- https://app.zencoder.com/docs/api/jobs --->
    <cffunction name="createJob" output="false">
        <cfargument name="input" type="string" required="true" />
        <cfargument name="outputs" type="any" required="false" />
        <cfargument name="passThrough" type="string" default="" />

        <cfset var job = {} />
        <cfset var theUrl = variables.apiEndpoint & "jobs" />
        <cfset var response = "" />

        <cfset job["input"] = arguments.input />

        <cfif structKeyExists(arguments, "outputs")>
            <cfset job["outputs"] = arguments.outputs />
        </cfif>

        <cfif Len(Trim(arguments.passThrough))>
            <cfset job["pass_through"] = arguments.passThrough />
        </cfif>

        <cfset response = sendRequest(theUrl, "post", job) />

        <cfset response = deserializeJSON(response.fileContent.toString()) />

        <cfreturn response />
    </cffunction>

    <cffunction name="listJobs" output="false">
        <cfset var theUrl = variables.apiEndpoint & "jobs" />
        <cfset var rawResponse = sendRequest(theUrl, "get") />
        <cfset var response = {} />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <cffunction name="getJobDetails" output="false">
        <cfargument name="jobID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "jobs/#arguments.jobID#.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <cffunction name="resubmitJob" output="false"
        hint="https://app.zencoder.com/docs/api/jobs/resubmit">
        <cfargument name="jobID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "jobs/#arguments.jobID#/resubmit.json" />
        <cfset var rawResponse = "" />

        <cfset rawResponse = sendRequest(theURL, "put") />

        <cfreturn rawResponse.statusCode />
    </cffunction>

    <cffunction name="cancelJob" output="false"
        hint="https://app.zencoder.com/docs/api/jobs/cancel">
        <cfargument name="jobID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "jobs/#arguments.jobID#/cancel.json" />
        <cfset var rawResponse = "" />

        <cfset rawResponse = sendRequest(theURL, "put") />

        <cfreturn rawResponse.statusCode />
    </cffunction>

    <cffunction name="jobProgress" output="false"
        hint="https://app.zencoder.com/docs/api/jobs/progress">
        <cfargument name="jobID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "jobs/#arguments.jobID#/progress.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <!--- https://app.zencoder.com/docs/api/inputs --->
    <cffunction name="getInputDetails" output="false"
        hint="https://app.zencoder.com/docs/api/inputs/show">
        <cfargument name="inputID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "inputs/#arguments.inputID#.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <cffunction name="inputProgress" output="false"
        hint="https://app.zencoder.com/docs/api/inputs/progress">
        <cfargument name="inputID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "inputs/#arguments.inputID#/progress.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <!--- https://app.zencoder.com/docs/api/outputs --->
    <cffunction name="getOutputDetails" output="false">
        <cfargument name="outputID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "outputs/#arguments.outputID#.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <cffunction name="outputProgress" output="false"
        hint="https://app.zencoder.com/docs/api/outputs/progress">
        <cfargument name="outputID" type="numeric" required="true" />

        <cfset var theURL = variables.apiEndpoint & "outputs/#arguments.outputID#/progress.json" />
        <cfset var rawResponse = "" />
        <cfset var response = {} />

        <cfset rawResponse = sendRequest(theURL, "get") />

        <cfif rawResponse.statusCode EQ "200 OK">
            <cfset response = deserializeJSON(rawResponse.fileContent.toString()) />
        </cfif>

        <cfreturn response />
    </cffunction>

    <!--- private methods --->
    <cffunction name="sendRequest" output="false">
        <cfargument name="theUrl" type="string" required="true" />
        <cfargument name="method" type="string" default="get" />
        <cfargument name="body" type="any" required="false" />

        <cfset var httpResponse = "" />

        <cfhttp url="#arguments.theUrl#" method="#arguments.method#" timeout="30" result="httpResponse">
            <cfhttpparam type="header" name="Content-Type" value="application/json" />
            <cfhttpparam type="header" name="Accept" value="application/json" />
            <cfhttpparam type="header" name="Zencoder-Api-Key" value="#variables.apiKey#" />

            <cfif structKeyExists(arguments, "body")>
                <cfhttpparam type="body" value="#SerializeJSON(arguments.body)#" />
            </cfif>
        </cfhttp>

        <cfreturn httpResponse />
    </cffunction>

</cfcomponent>