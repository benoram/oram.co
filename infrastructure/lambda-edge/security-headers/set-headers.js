'use strict';

exports.handler = (event, context, callback) => {
		const request = event.Records[0].cf.request;
		const response = event.Records[0].cf.response;
		const headers = response.headers;

		headers["strict-transport-security"] = [
				{
						key: "Strict-Transport-Security", 
						value: "max-age=31536000; includeSubDomains; preload"
				}
		];

		headers['x-content-type-options'] = [
				{
						key: 'X-Content-Type-Options', 
						value: 'nosniff'
				}
		]; 

		headers['x-frame-options'] = [
				{
						key: 'X-Frame-Options', 
						value: 'DENY'
				}
		]; 

		headers['x-xss-protection'] = [
				{
						key: 'X-XSS-Protection', 
						value: '1; mode=block'
				}
		];

		headers['referrer-policy'] = [
				{
						key: 'Referrer-Policy', 
						value: 'same-origin'
				}
		]; 

		headers["feature-policy" = [
				{
						key: 'Feature-Policy',
						value: "accelerometer 'none'; " +
									 "ambient-light-sensor 'none'; " +
									 "autoplay 'none'; " +
									 "camera 'none'; " +
									 "encrypted-media 'none'; " +
									 "focus-without-user-activation 'none'; " +
									 "fullscreen 'none'; geolocation 'none'; " +
									 "gyroscope 'none'; magnetometer 'none'; " +
									 "microphone 'none'; midi 'none'; " +
									 "payment 'none'; " +
									 "picture-in-picture 'none'; " +
									 "speaker 'none'; " +
									 "sync-xhr 'none'; " +
									 "usb 'none'; " +
									 "vr 'none'"
				}
		]];
	
		
		// headers['content-security-policy'] = [
		// 		{
		// 				key: 'Content-Security-Policy', 
		// 				value: "default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'"
		// 		}
		// ]; 

		callback(null, response);
};