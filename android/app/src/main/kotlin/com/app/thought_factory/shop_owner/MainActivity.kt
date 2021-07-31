package com.app.thought_factory.shop_owner

//import io.flutter.embedding.android.FlutterActivity
import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.ViewTreeObserver
import android.view.WindowManager
import android.widget.Toast
import com.app.thought_factory.shop_owner.remote.ApiInterface
import com.app.thought_factory.shop_owner.request_response.request_payment.Authorization
import com.app.thought_factory.shop_owner.request_response.request_payment.DetailsRequest
import com.shatech.customerdetailapp.response.DetailsResponse
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.*
import kotlin.collections.HashMap


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.startActivity/testChannel"
    val LAUNCH_SECOND_ACTIVITY: Int = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        //Remove full screen flag after load
        val viewTreeObserver: ViewTreeObserver = flutterView.viewTreeObserver
        viewTreeObserver.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
            override fun onGlobalLayout() {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                    flutterView.viewTreeObserver.removeOnGlobalLayoutListener(this)
                    window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
                }
            }
        })

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals("StartSecondActivity")) {
                val arg: Map<String, Objects> = call.arguments()
                //print(arg.get("vimeoId").toString())
                /*val intent= Intent(this,PaymentApiCallingActivity::class.java)
                intent.putExtra("Customer", arg.get("Customer").toString())
                intent.putExtra("Language", arg.get("Language").toString())
                intent.putExtra("Currency", arg.get("Currency").toString())
                intent.putExtra("OrderName", arg.get("OrderName").toString())
                intent.putExtra("OrderID", arg.get("OrderID").toString())
                intent.putExtra("Channel", arg.get("Channel").toString())
                intent.putExtra("Amount", arg.get("Amount").toString())
                intent.putExtra("TransactionHint", arg.get("TransactionHint").toString())
                intent.putExtra("CardNumber", arg.get("CardNumber").toString())
                intent.putExtra("ExpiryMonth", arg.get("ExpiryMonth").toString())
                intent.putExtra("ExpiryYear", arg.get("ExpiryYear").toString())
                intent.putExtra("VerifyCode", arg.get("VerifyCode").toString())
                intent.putExtra("UserName", arg.get("UserName").toString())
                intent.putExtra("Password", arg.get("Password").toString())

//                intent.putExtra("isUserPaid", arg["isPaid"] as Boolean)
//                intent.putExtra("isVideo", true)
//                intent.putExtra("isShort", false)
                //startActivity(intent)
                startActivityForResult(intent, LAUNCH_SECOND_ACTIVITY)*/
                val retrofit: Retrofit = Retrofit.Builder()
                        //.client(client)
                        .baseUrl("https://demo-ipg.ctdev.comtrust.ae:2443")
                        .addConverterFactory(GsonConverterFactory.create())
                        .build()


                fun obj(): DetailsRequest {
                    return DetailsRequest(
                            Authorization(
                                    Amount = arg.get("Amount").toString(), //"28.90",
                                    CardNumber = arg.get("CardNumber").toString(), //"4111111111111111",
                                    Channel = arg.get("Channel").toString(), //"W",
                                    Currency = arg.get("Currency").toString(), //"AED",
                                    Customer = arg.get("Customer").toString(), //"Demo Merchant",
                                    ExpiryMonth = arg.get("ExpiryMonth").toString(), //"12",
                                    ExpiryYear = arg.get("ExpiryYear").toString(), //"2021",
                                    Language = arg.get("Language").toString(), //"en",
                                    OrderID = arg.get("OrderID").toString(),//"000000575",
                                    OrderName = arg.get("OrderName").toString(), //"Parle Kreams Gold - ",
                                    Password = arg.get("Password").toString(),//"Comtrust@20182018",
                                    TransactionHint = arg.get("TransactionHint").toString(), // "CPT:Y;",
                                    UserName = arg.get("UserName").toString(), //"Demo_fY9c",
                                    VerifyCode = arg.get("VerifyCode").toString() //"123"
                            )
                    )
                }


                val request = retrofit.create(ApiInterface::class.java)

                request.apiPaymentCall(obj()).enqueue(object : Callback<DetailsResponse?> {
                    override fun onResponse(
                            call: Call<DetailsResponse?>,
                            response: Response<DetailsResponse?>
                    ) {
                        println("Response Success---->${response.body()}")
                        if (response.isSuccessful) {
                            print("Payment Success")
                            response.body().let {
                                if (it != null) {
                                    if (it.Transaction.ResponseClassDescription.equals("Success")) {
                                        //val returnArg: Map<Int, String> = mapOf<Int, String>(1 to "Success", 2 to it.Transaction.ResponseDescription.toString())
                                        val returnArg: HashMap<Int, String> = HashMap<Int, String>()
                                        returnArg.put(1, "Success")
                                        returnArg.put(2, it.Transaction.ResponseDescription.toString())
                                        result.success(returnArg)
                                        /* val returnIntent = Intent()
                                         returnIntent.putExtra("flag", true)
                                         returnIntent.putExtra("message", it.Transaction.ResponseDescription)
                                         setResult(Activity.RESULT_OK, returnIntent)
                                         finish()*/
                                    } else if (it.Transaction.ResponseClassDescription.equals("Error")) {
                                        val returnArg: HashMap<Int, String> = HashMap<Int, String>()
                                        returnArg.put(1, "Error")
                                        returnArg.put(2, it.Transaction.ResponseDescription.toString())
                                        result.success(returnArg)
                                        /* val returnIntent = Intent()
                                         returnIntent.putExtra("flag", false)
                                         returnIntent.putExtra("message", it.Transaction.ResponseDescription)
                                         setResult(Activity.RESULT_OK, returnIntent)
                                         finish()*/
                                    } else {
                                        val returnArg: HashMap<Int, String> = HashMap<Int, String>()
                                        returnArg.put(1, "Error")
                                        returnArg.put(2, "SomeThing went wrong, Please try again later.")
                                        result.success(returnArg)
                                        /*val returnIntent = Intent()
                                        setResult(Activity.RESULT_CANCELED, returnIntent)
                                        finish()*/
                                        Toast.makeText(
                                                applicationContext,
                                                it.Transaction.ResponseDescription,
                                                Toast.LENGTH_LONG
                                        ).show()
                                    }
                                } else {
                                    val returnArg: HashMap<Int, String> = HashMap<Int, String>()
                                    returnArg.put(1, "Error")
                                    returnArg.put(2, "SomeThing went wrong, Please try again later.")
                                    result.success(returnArg)
                                    /*val returnIntent = Intent()
                                    setResult(Activity.RESULT_CANCELED, returnIntent)
                                    finish()*/
                                }
                            }
                        }
                    }

                    override fun onFailure(call: Call<DetailsResponse?>, t: Throwable) {
                        println("Response Failure---->${t}")
                    }
                })

            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode === LAUNCH_SECOND_ACTIVITY) {
            if (resultCode === Activity.RESULT_OK) {
                val result = data!!.getStringExtra("result")

            }
            if (resultCode === Activity.RESULT_CANCELED) {
                Toast.makeText(
                        applicationContext,
                        "Something went wrong, Please try again later.",
                        Toast.LENGTH_LONG
                ).show()
                //Write your code if there's no result
            }
        }
    }

}

