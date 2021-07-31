package com.app.thought_factory.shop_owner.remote

import com.app.thought_factory.shop_owner.request_response.request_payment.DetailsRequest
import com.shatech.customerdetailapp.response.DetailsResponse
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Headers
import retrofit2.http.POST

interface ApiInterface {
    @Headers("Content-Type: application/json",
        "Accept: application/json")
    @POST("https://demo-ipg.ctdev.comtrust.ae:2443")
    fun apiPaymentCall(@Body detailsRequest: DetailsRequest) : Call<DetailsResponse?>
}