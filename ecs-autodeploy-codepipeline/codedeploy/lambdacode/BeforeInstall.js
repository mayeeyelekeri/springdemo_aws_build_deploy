'use strict';
 
 const AWS = require('aws-sdk');
 const codedeploy = new AWS.CodeDeploy({apiVersion: '2014-10-06'});
 
 exports.handler = (event, context, callback) => {
 
    console.log("Entering BeforeInstall hook.");
    
    // Read the DeploymentId and LifecycleEventHookExecutionId from the event payload
    var deploymentId = event.DeploymentId;
    var lifecycleEventHookExecutionId = event.LifecycleEventHookExecutionId;
    var validationTestResult = "Failed";
    console.log("deploymentId: ${deploymentId}"); 
    console.log("event info: ${event}"); 
    console.log("context: ${context}"); 
    // Perform AfterAllowTestTraffic validation tests here. Set the test result 
    // to "Succeeded" for this tutorial.
    console.log("This is where BeforeInstall validation tests happen.")
    validationTestResult = "Succeeded";
    
    // Complete the BeforeInstall hook by sending CodeDeploy the validation status
    var params = {
        deploymentId: deploymentId,
        lifecycleEventHookExecutionId: lifecycleEventHookExecutionId,
        status: validationTestResult // status can be 'Succeeded' or 'Failed'
    };
    
    // Pass CodeDeploy the prepared validation test results.
    codedeploy.putLifecycleEventHookExecutionStatus(params, function(err, data) {
        if (err) {
            // Validation failed.
            console.log('BeforeInstall validation tests failed');
            console.log(err, err.stack);
            callback("CodeDeploy Status update failed");
        } else {
            // Validation succeeded.
            console.log("BeforeInstall validation tests succeeded");
            callback(null, "BeforeInstall validation tests succeeded");
        }
    });
 }  
 