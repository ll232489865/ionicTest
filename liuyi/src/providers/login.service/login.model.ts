export class LoginHandshakeModel {
    serverSign: string;
    serverGreeting: string;
}

export class model_loginResult {

    // {"result":{"md5key":"0.02729542608542157","uuid":"a88121420d3d4e3383b65311e21334eb","token":"82170a871d084c9992a17e61129982c6","latestRequests":{},"requestThreshold":10},"resultCode":"0","resultMsg":"执行成功！"}
    md5key: string;
    uuid: string;
    token: string;
    latestRequests: string;
    requestThreshold: string;
}