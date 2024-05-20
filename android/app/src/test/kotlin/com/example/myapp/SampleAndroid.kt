package com.example.myapp;

import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.android.AndroidDriver;

public class SampleAndroid {
    private final String URL_STRING = "http://127.0.0.1:4723/";

    //https://kobiton.com/blog/understanding-appium-desired-capabilities/
    @Test
    public void test_android_test() throws MalformedURLException, InterruptedException {
        System.out.println("Android Test");
        URL url = new URL(URL_STRING);
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability("automationName", "UiAutomator2");
        capabilities.setCapability("deviceName", "emulator-5554");
        capabilities.setCapability("platformName", "android");
        capabilities.setCapability("app", "build/app/outputs/flutter-apk/app-debug.apk");
        AppiumDriver driver = new AndroidDriver(url, capabilities);
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(2));
        System.out.println("Android Driver Initialized");

        WebElement pageHeading = driver.findElement(By.xpath("//*[@content-desc='Flutter Demo Home Page']"));
        WebElement countText = driver.findElement(By.
                xpath("//*[@content-desc='You have pushed the button this many times:']"));
        WebElement countValue = driver.findElement(By.
                xpath("//*[@content-desc='You have pushed the button this many times:']/following-sibling::android.view.View"));
        WebElement incrementButton = driver.findElement(AppiumBy.accessibilityId("Plus Button"));
        Assert.assertTrue(pageHeading.isDisplayed());
        Assert.assertTrue(countText.isDisplayed());
        Assert.assertEquals(countValue.getAttribute("content-desc"), "0");
        System.out.println("Asserted Initial Count: 0");
        Assert.assertTrue(incrementButton.isDisplayed());
        incrementButton.click();
        System.out.println("Clicked Increment");
        Thread.sleep(5 * 1000);
        Assert.assertEquals(countValue.getAttribute("content-desc"), "1");
        System.out.println("Asserted Updated Count: 1");
        System.out.println("Android Test: Success");
    }
}