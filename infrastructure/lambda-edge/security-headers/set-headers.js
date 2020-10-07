'use strict';

exports.handler = (event, context, callback) => {
	const request = event.Records[0].cf.request;
	const response = event.Records[0].cf.response;
	const headers = response.headers;

	headers["strict-transport-security"] = [{
		key: "Strict-Transport-Security", 
		value: "max-age=31536000; includeSubDomains; preload"
	}];
    
	callback(null, response);
};