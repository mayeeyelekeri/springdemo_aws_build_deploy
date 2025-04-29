'use strict';
 
 const AWS = require('aws-sdk');
 const codedeploy = new AWS.CodeDeploy({apiVersion: '2014-10-06'});
 
 exports.handler = (event, context, callback) => {
 
    console.log("Entering AfterInstall hook.");
    
    // Read the DeploymentId and LifecycleEventHookExecutionId from the event payload
  var deploymentId = event.DeploymentId;
    var lifecycleEventHookExecutionId = event.LifecycleEventHookExecutionId;
    var validationTestResult = "Failed";
    
    // Perform AfterInstall validation tests here. Set the test result 
    // to "Succeeded" for this tutorial.
    console.log("This is where AfterInstall validation tests happen.")
    validationTestResult = "Succeeded";
    
    // Complete the AfterInstall hook by sending CodeDeploy the validation status
    var params = {
        deploymentId: deploymentId,
        lifecycleEventHookExecutionId: lifecycleEventHookExecutionId,
        status: validationTestResult // status can be 'Succeeded' or 'Failed'
    };
    
    // Pass CodeDeploy the prepared validation test results.
    codedeploy.putLifecycleEventHookExecutionStatus(params, function(err, data) {
        if (err) {
            // Validation failed.
            console.log('AfterInstall validation tests failed');
            console.log(err, err.stack);
            callback("CodeDeploy Status update failed");
        } else {
            // Validation succeeded.
            console.log("AfterInstall validation tests succeeded");
            callback(null, "AfterInstall validation tests succeeded");
        }
    });
 }  
 