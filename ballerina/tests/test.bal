// Copyright (c) 2025, WSO2.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/io;

configurable ApiKeysConfig apiKeyConfig = ?;
final string serviceUrl = "https://api.temenos.com/api/v2.4.0/holdings/transactions"; // Fixed double slash
configurable string accountId = "156396";
configurable string listType = "RECENT";
configurable string transactionCount = "10";
// configurable string customerId = "190317";
// configurable string taxRate = "10";
// configurable string transactionAmount = "1000";
// configurable string transactionCurrency = "USD";
// configurable string transactionReference = "AAACT25100YLCHKPRK";
// configurable string entryReference = "209068141701763.220001";



final ConnectionConfig config = {
    auth: apiKeyConfig
};

final Client temenos = check new (config, serviceUrl);

@test:Config {
    groups: ["get_test"]
}
isolated function testGetTransactionDetails() returns error? {
    GetAccountTransactionsQueries queries = {
        listType: listType,
        accountId: accountId,
        transactionCount: transactionCount
    };
    AccountTransactionsResponse|error response = temenos->/.get(queries = queries);
    if response is AccountTransactionsResponse {
        io:println("Success Response: ", response);
        test:assertTrue(true, "Successfully retrieved transaction details");
    } else {
        io:println("Error Response: ", response.message());
        test:assertFail("Failed to retrieve transaction details: " + response.message());
    }
}

