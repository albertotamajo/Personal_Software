
import com.jauntium.JauntiumException;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.*;
import java.util.List;

public class SeleniumClass {

    public static void main(String[] args) throws InterruptedException, JauntiumException, IOException, ParserConfigurationException, SAXException {

        System.setProperty("webdriver.gecko.driver","C:\\Users\\tamaj\\OneDrive\\GeckoDriver\\geckodriver.exe");

        File file = new File("C:\\Users\\tamaj\\OneDrive\\University of Southampton\\Programming II\\Selenium\\src\\subito.txt");
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbFactory.newDocumentBuilder();
        Document doc = db.parse(file);
        doc.getDocumentElement().normalize();
        NodeList nodeList = doc.getElementsByTagName("Annuncio");

        FirefoxDriver webDriver = new FirefoxDriver();
        webDriver.get("https://areariservata.subito.it/login_form");
        WebElement email = webDriver.findElement(By.id("login_email"));
        WebElement password = webDriver.findElement(By.id("login_passwd"));



        NodeList emailText = doc.getElementsByTagName("Email");
        NodeList passwordText = doc.getElementsByTagName("Password");

        for(int x=0; x<emailText.getLength();x++){
            email.sendKeys(emailText.item(x).getTextContent());
        }

        for(int x=0; x<passwordText.getLength();x++){
            password.sendKeys(passwordText.item(x).getTextContent());
            password.submit();
        }





        Thread.sleep(12000);
        WebElement banner = webDriver.findElement(By.xpath("//button[@class='optanon-alert-box-close banner-close-button']"));
        if (banner.isDisplayed()){
            banner.click();
        }

        List<WebElement> checkBoxes = webDriver.findElements(By.xpath("//input[@type='checkbox' and @name='ids[]']"));
        if(!checkBoxes.isEmpty()) {
            for (WebElement element : checkBoxes) {
                element.click();
            }
        }

        Thread.sleep(300);
        WebElement deleteButton = webDriver.findElement(By.xpath("//div[@class='icon_20 icon_enabled reserved_area-icon20-elimina-blu']"));
        if(deleteButton.isDisplayed()) {
            deleteButton.click();
        }


        Thread.sleep(300);
        WebElement deleteReason = webDriver.findElement(By.xpath("//input[@name='delete_reason_overlay' and @value='1']"));
        if(deleteReason.isDisplayed()) {
            deleteReason.click();
        }

        Thread.sleep(100);
        WebElement buttonDeleteAds = webDriver.findElement(By.id("btnDelAds"));
        if(buttonDeleteAds.isDisplayed()) {
            buttonDeleteAds.click();
        }

        Thread.sleep(300);

        Alert alert = webDriver.switchTo().alert();

        alert.accept();

        webDriver.switchTo().defaultContent();

        for(int i=0; i<nodeList.getLength();i++){

            Element element=(Element) nodeList.item(i);

            String title="";
            String announcementBody="";
            String price="";
            String size="";
            String rooms="";
            String town="";
            String name="";
            String phone="";
            String address="";
            String[] imagePaths = new String[1];

            NodeList titleList = element.getElementsByTagName("TitoloAnnuncio");
            for(int x=0; x<titleList.getLength();x++){
                title=titleList.item(0).getTextContent();
            }

            NodeList announcementList = element.getElementsByTagName("Descrizione");
            for(int x=0; x<announcementList.getLength();x++){
                announcementBody=announcementList.item(0).getTextContent();
            }

            NodeList priceList = element.getElementsByTagName("Prezzo");
            for(int x=0; x<priceList.getLength();x++){
                price=priceList.item(0).getTextContent();
            }

            NodeList sizeList = element.getElementsByTagName("Dimensioni");
            for(int x=0; x<sizeList.getLength();x++){
                size=sizeList.item(0).getTextContent();
            }



            NodeList roomsList = element.getElementsByTagName("NumeroVani");
            for(int x=0; x<roomsList.getLength();x++){
                rooms=roomsList.item(0).getTextContent();
            }

            NodeList townList = element.getElementsByTagName("Città");
            for(int x=0; x<townList.getLength();x++){
                town=townList.item(0).getTextContent();
            }

            NodeList nameList = element.getElementsByTagName("Nome");
            for(int x=0; x<nameList.getLength();x++){
                name=nameList.item(0).getTextContent();
            }

            NodeList phoneList = element.getElementsByTagName("Telefono");
            for(int x=0; x<phoneList.getLength();x++){
                phone=phoneList.item(x).getTextContent();
            }

            NodeList imageList = element.getElementsByTagName("Immagine");
            imagePaths = new String[imageList.getLength()];
            for(int x=0; x<imageList.getLength();x++){
                imagePaths[x]="C:\\Users\\tamaj\\OneDrive\\University of Southampton\\Programming II\\Selenium\\src\\"+ imageList.item(x).getTextContent();
            }

            NodeList addressList = element.getElementsByTagName("Indirizzo");
            for(int x=0; x < addressList.getLength();x++){
                address=addressList.item(x).getTextContent();
            }

            Thread.sleep(300);

            if(i!=0) {

                webDriver.get("https://areariservata.subito.it/login_form");



                emailText = doc.getElementsByTagName("Email");
                passwordText = doc.getElementsByTagName("Password");

                for(int x=0; x<emailText.getLength();x++){
                    email.sendKeys(emailText.item(x).getTextContent());
                }

                for(int x=0; x<passwordText.getLength();x++){
                    password.sendKeys(passwordText.item(x).getTextContent());
                    password.submit();
                }
            }

            Thread.sleep(300);
            webDriver.get("https://www2.subito.it/aif#insert");
            Thread.sleep(12000);



            Select category = new Select(webDriver.findElement(By.name("category")));
            category.selectByVisibleText("Case vacanza");

            WebElement announcementType = webDriver.findElement(By.name("type"));


            WebElement announcementTitle = webDriver.findElement(By.id("subject"));
            announcementTitle.clear();
            announcementTitle.sendKeys(title);

            WebElement bodyText = webDriver.findElement(By.id("body"));
            bodyText.clear();
            bodyText.sendKeys(announcementBody);

            WebElement priceText = webDriver.findElement(By.id("price"));
            priceText.clear();
            priceText.sendKeys(price);

            WebElement sizeText = webDriver.findElement(By.id("size"));
            sizeText.clear();
            sizeText.sendKeys(size);

            Thread.sleep(3000);
            Select roomstext = new Select(webDriver.findElement(By.name("rooms")));
            roomstext.selectByVisibleText(rooms);



            WebElement townText = webDriver.findElement(By.id("town"));
            townText.clear();
            townText.sendKeys(town);

            Thread.sleep(300);

            WebElement visibleMap = webDriver.findElement(By.xpath("//input[@name='visMappa' and @value='1']"));
            visibleMap.click();

            Thread.sleep(300);

            WebElement addressText = webDriver.findElement(By.id("address"));
            addressText.clear();
            addressText.sendKeys(address);


            WebElement buttonMap = webDriver.findElement(By.id("findonmap"));
            buttonMap.click();


            WebElement nameText = webDriver.findElement(By.id("name"));
            nameText.clear();
            nameText.sendKeys(name);

            WebElement phoneText = webDriver.findElement(By.id("phone"));
            phoneText.clear();
            phoneText.sendKeys(phone);


            WebElement pictures = webDriver.findElement(By.xpath("//input[@type='file']"));

            if(imagePaths.length==5){
                pictures.sendKeys(imagePaths[0]+"\n"+imagePaths[1]+"\n"+imagePaths[2]+"\n"+imagePaths[3]+"\n"+imagePaths[4]);
            }
            if (imagePaths.length==4){
                pictures.sendKeys(imagePaths[0]+"\n"+imagePaths[1]+"\n"+imagePaths[2]+"\n"+imagePaths[3]);

            }

            if (imagePaths.length==3){
                pictures.sendKeys(imagePaths[0]+"\n"+imagePaths[1]+"\n"+imagePaths[2]);
            }

            WebElement button = webDriver.findElement(By.id("btnAiSubmit"));
            button.click();

            Thread.sleep(120000);
            WebElement buttonconfirm = webDriver.findElement(By.id("btnConfirm"));
            buttonconfirm.click();

            webDriver.get("https://areariservata.subito.it/logout");
            Thread.sleep(300);

        }



    }

}
