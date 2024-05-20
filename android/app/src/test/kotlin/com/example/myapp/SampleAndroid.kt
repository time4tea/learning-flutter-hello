package com.example.myapp

import io.appium.java_client.AppiumBy
import io.appium.java_client.AppiumDriver
import io.appium.java_client.android.AndroidDriver
import io.appium.java_client.screenrecording.CanRecordScreen
import org.junit.Assert
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestName
import org.openqa.selenium.By
import org.openqa.selenium.WebElement
import org.openqa.selenium.remote.DesiredCapabilities
import org.openqa.selenium.support.ui.FluentWait
import java.io.File
import java.net.URL
import java.time.Duration
import java.util.Base64


class SampleAndroid {
    private val URL_STRING = "http://127.0.0.1:4723/"

    //https://kobiton.com/blog/understanding-appium-desired-capabilities/

    @JvmField
    @Rule
    val name: TestName = TestName()

    fun String.decodeBase64(): ByteArray {
        return Base64.getDecoder().decode(this)
    }

    fun TestName.toFilesystemCompatible(): String = methodName.replace("[^A-Za-z_-]+".toRegex(), "_")

    fun AppiumDriver.recordingScreen(f: AppiumDriver.() -> Unit) {
        when (this) {
            is CanRecordScreen -> println(this.startRecordingScreen())
        }
        try {
            f(this)
        } finally {
            when (this) {
                is CanRecordScreen -> {
                    File("test-recording-${name.toFilesystemCompatible()}.mp4").writeBytes(
                        this.stopRecordingScreen().decodeBase64()
                    )
                }
            }
        }
    }

    fun WebElement.expecting(f: WebElement.() -> Boolean) {
        FluentWait(this).until(f)
    }

    @Test
    fun test_android_test() {
        println("Android Test")
        val url = URL(URL_STRING)
        val capabilities = DesiredCapabilities()
        capabilities.setCapability("automationName", "UiAutomator2")
        capabilities.setCapability("deviceName", "emulator-5554")
        capabilities.setCapability("platformName", "android")
        capabilities.setCapability("app", "build/app/outputs/flutter-apk/app-debug.apk")
        val driver: AppiumDriver = AndroidDriver(url, capabilities)
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(2))
        println("Android Driver Initialized")

        driver.recordingScreen {
            val countText = driver.findElement(
                By.xpath
                    ("//*[@content-desc='You have pushed the button this many times:']")
            )

            val countValue = driver.findElement(
                By.xpath
                    ("//*[@content-desc='You have pushed the button this many times:']/following-sibling::android.view.View")
            )

            driver.findElement(By.xpath("//*[@content-desc='Flutter Demo Home Page']"))
                .expecting { isDisplayed }

            countText.expecting { isDisplayed }
            countValue.expecting { getAttribute("content-desc") == "0" }
            println("Asserted Initial Count: 0")

            val incrementButton = driver.findElement(AppiumBy.accessibilityId("Plus Button"))
            incrementButton.expecting { isDisplayed }
            incrementButton.click()
            println("Clicked Increment")
            countValue.expecting { getAttribute("content-desc") == "1" }
            println("Asserted Updated Count: 1")
            println("Android Test: Success")
        }
    }
}