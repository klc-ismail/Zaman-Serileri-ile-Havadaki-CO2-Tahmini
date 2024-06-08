library(fpp)
library(forecast)
library(readxl)
library(haven)
veri<- read_excel("C:/Users/Asus/Desktop/zaman_serileri/co2veriseti.xlsx")
View(veri)
veri_ts <- ts(veri, start = c(2012, 01), frequency = 12)
veri_ts


ts.plot(veri_ts, gpars = list(xlab = "Zaman", ylab = "CO2_ppm"))

#### gecikme grafiği
veri1_lagts <- lag(veri_ts-1)
veri2_lagts <- lag(veri_ts-2)

plot(window(veri_ts), xlab = "Zaman", ylab = "CO2_ppm", lty = 1,
     col = 4, lwd = 2)
lines(window(veri1_lagts), lty = 3, col = 2, lwd = 2)
lines(window(veri2_lagts), lty = 2, col = 3, lwd = 2)
legend("topleft",c(expression(paste(co2_ppm)),
                   expression(paste(LAGS("1.Gecikme",1))),
                   expression(paste(LAGS("2. Gecikme",2)))),lwd=c(2,2,2),lty = c(1,3,2),cex=0.6,
                    col = c(4,2,3))


Acf(veri_ts,lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(veri_ts,lag.max = 42, ylim=c(-1,1), lwd=3)

Acf(diff(veri_ts),lag.max = 42, ylim=c(-1,1), lwd=3)
Pacf(diff(veri_ts),lag.max = 42, ylim=c(-1,1), lwd=3)

Acf(diff(diff(veri_ts,12)),lag.max = 42, ylim=c(-1,1), lwd=3)
Pacf(diff(diff(veri_ts,12)),lag.max = 42, ylim=c(-1,1), lwd=3)



#### toplamsal ayrışma
library(fpp)
library(stats)

veri_trent <- tslm(veri_ts~trend)
periyot <- veri_ts - veri_trent[["fitted.values"]]
veri1_ts <- ma(veri_ts, order = 12, centre = TRUE)
Mevsim <- veri_ts - veri1_ts

donemort <- t(matrix(data = Mevsim, nrow = 12))
endeks <- colMeans(donemort, na.rm = T) - mean(colMeans(donemort,na.rm = T))
indeks <- matrix(data=endeks,nrow = 81)
indeks_alternatif <- decompose(veri_ts,"additive")
trenthata <- veri_ts-indeks
trent <- tslm(trenthata~trend)
tahmin<- indeks+trent[["fitted.values"]]
hata<- veri_ts-indeks-trent[["fitted.values"]]

plot( window(veri_ts), 
      xlab="Zaman", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(co2_ppm )),
                   expression(paste(Tahmin ))),
       lwd=c(2,2),lty=c(1,3), cex=0.6, col=c(4,2))

Acf(hata,main="Hata", lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(hata,main="Hata",lag.max = 42, ylim=c(-1,1), lwd=3)

Box.test(hata, lag = 42, type = "Ljung")


### çarpımsal 
Mevsim_X <- veri_ts/veri1_ts
donemort_x<-t(matrix(data=Mevsim_X, nrow=12))
colMeans(donemort_x, na.rm = T)
sum(colMeans(donemort_x, na.rm = T))
mean(colMeans(donemort_x, na.rm = T))
endeks_X<- colMeans(donemort_x, na.rm = T)/mean(colMeans(donemort_x, na.rm = T))
indeks_X<-  matrix(data = endeks_X, nrow = 81)

trenthata_X<- veri_ts/indeks_X
trent_X<- tslm(trenthata_X~trend)
tahmin_x<- indeks_X*trent_X[["fitted.values"]] 
hata_X<- veri_ts-tahmin_x

plot( window(veri_ts), 
      xlab="Zaman", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin_x) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(co2_ppm )),
                   expression(paste(Tahmin ))),
       lwd=c(2,2),lty=c(1,3), cex=0.6, col=c(4,2))


Acf(hata_X,main="Hata", lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(hata_X,main="Hata",lag.max = 42, ylim=c(-1,1), lwd=3)
Box.test(hata_X, lag = 42, type = "Ljung")




#### zaman serilerinde regresyon analizi
###########toplamsal
t<- 1: length(veri_ts)
t

sin1 <- sin(2*3.1416*t/12)
cos1 <- cos(2*3.1416*t/12)

veriseti_1 <- as.data.frame(cbind(veri, t, sin1, cos1))
attach(veriseti_1)
names(veriseti_1) <- c("co2_ppm","t","sin1","cos1")
regresyon.model1 <- lm(co2_ppm ~ t+sin1+cos1)
summary(regresyon.model1)
regresyon.model1


###2. harmonik

sin2 <- sin(2*3.1416*2*t/12)
cos2 <- cos(2*3.1416*2*t/12)

veriseti_2 <- as.data.frame(cbind(veri, t, sin1, cos1,sin2,cos2))
attach(veriseti_2)
names(veriseti_2) <- c("co2_ppm","t","sin1","cos1","sin2","cos2")
regresyon.model2 <- lm(co2_ppm ~ t+sin1+cos1+sin2+cos2)
summary(regresyon.model2)
regresyon.model2


###3. harmonik

sin3 <- sin(2*3.1416*3*t/12)
cos3 <- cos(2*3.1416*3*t/12)

veriseti_3 <- as.data.frame(cbind(veri, t, sin1, cos1,sin2,cos2,sin3,cos3))
attach(veriseti_3)
names(veriseti_3) <- c("co2_ppm","t","sin1","cos1","sin2","cos2","sin3","cos3")
regresyon.model3 <- lm(co2_ppm ~ t+sin1+cos1+sin2+cos2+sin3+cos3)
summary(regresyon.model3)
regresyon.model3


dwtest(co2_ppm~t+sin1+cos1+sin2+cos2)

tahmin2 <- predict(regresyon.model2)
sinir2 <- predict(regresyon.model2, interval='confidence', level=0.95)
hata2 <- resid(regresyon.model2)

regresyon.model2



plot( window(co2_ppm), xlab="", ylab="", type="l", lty=3, col=2, lwd=2)
lines(window(sinir2[,2]) ,type="l",lty=1,col=4,lwd=2)
lines(window(sinir2[,3]) ,type="l",lty=1,col=3,lwd=2)
legend("topleft",c(expression(paste(co2_ppm)),
                   expression(paste("Alt Sınır")),
                   expression(paste("Üst Sınır"))),
       lwd=c(2,2,2),lty=c(3,1,1), cex=0.7, col=c(2,4,3))


Acf(hata2,lag.max = 42,  ylim=c(-1,1), lwd=3)
Box.test(hata2, lag = 42, type = "Ljung")


############çarpımsal
t<- 1: length(veri_ts)
t

sinx1 <- t*sin(2*3.1416*t/12)
cosx1 <- t*cos(2*3.1416*t/12)

veriseti_x1 <- as.data.frame(cbind(veri, t, sinx1, cosx1))
attach(veriseti_x1)
names(veriseti_x1) <- c("co2_ppm","t","sinx1","cosx1")
regresyon.modelx1 <- lm(co2_ppm ~ t+sinx1+cosx1)
summary(regresyon.modelx1)
regresyon.modelx1


#çarpımsal için 2. harmonik
sinx2 <- t*sin(2*3.1416*2*t/12)
cosx2 <- t*cos(2*3.1416*2*t/12)

veriseti_x2 <- as.data.frame(cbind(veri, t, sinx1, cosx1, sinx2, cosx2))
attach(veriseti_x2)
names(veriseti_x2) <- c("co2_ppm","t","sinx1","cosx1","sinx2","cosx2")
regresyon.modelx2 <- lm(co2_ppm ~ t+sinx1+cosx1+sinx2+cosx2)
summary(regresyon.modelx2)
regresyon.modelx2


dwtest(co2_ppm~t+sinx1+cosx1)

tahminx1 <- predict(regresyon.modelx1)
sinirx1 <- predict(regresyon.modelx1, interval='confidence', level=0.95)
hatax1 <- resid(regresyon.modelx1)

regresyon.modelx1



plot( window(co2_ppm), xlab="", ylab="", type="l", lty=3, col=2, lwd=2)
lines(window(sinirx1[,2]) ,type="l",lty=1,col=4,lwd=2)
lines(window(sinirx1[,3]) ,type="l",lty=1,col=3,lwd=2)
legend("topleft",c(expression(paste(co2_ppm)),
                   expression(paste(Altsinir)),
                   expression(paste(Üstsinir))),
       lwd=c(2,2,2),lty=c(3,1,1), cex=0.7, col=c(2,4,3))



Acf(hatax1,lag.max = 42,  ylim=c(-1,1), lwd=3)
Box.test(hata2, lag = 42, type = "Ljung")



#################### üstel düzleştirme yöntemi
####### winters düzleştirme yöntemi yapacağız
Winters_toplamsal<- ets(veri_ts, model = "AAA")
summary(Winters_toplamsal)


Winters_carpimsal<- ets(abs(veri_ts), model = "MAM")
summary(Winters_carpimsal)



###toplamsal model ile tahmin edilir

tahmin_toplamsal<- Winters_toplamsal[["fitted"]]
plot( window(veri_ts), 
      xlab="Zaman", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin_toplamsal) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(CO2_PPM)),
                   expression(paste(Winters1Tahmin))),
       lwd=c(2,2),lty=c(1,3), cex=0.7, col=c(4,2))


tahmin_carpimsal <- Winters_carpimsal[["fitted"]]
plot( window(veri_ts), 
      xlab="Zaman", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin_carpimsala) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(Orjinalseri)),
                   expression(paste(Winters1Tahmin))),
       lwd=c(2,2),lty=c(1,3), cex=0.7, col=c(4,2))


#### toplamsal ile öngörü

hata_toplamsal<- Winters_toplamsal[["residuals"]]

Box.test (hata_toplamsal, lag = 42, type = "Ljung")

Acf(hata_toplamsal,main="Hata", lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(hata_toplamsal,main="Hata",lag.max = 42, ylim=c(-1,1), lwd=3)

checkresiduals(Winters_toplamsal, lag = 42)

ongoru <- forecast(Winters_toplamsal,h=5)
ongoru
ongoru[["mean"]]





##############box jenkins ile tahmin 


veri_arima <- Arima(veri_ts, order = c(1,1,0), seasonal= c(1,1,0), include.constant=TRUE)
summary(veri_arima)
coeftest(veri_arima)

veri_arima <- Arima(veri_ts, order = c(0,1,0), seasonal= c(0,1,1), include.constant=TRUE)
summary(veri_arima)
coeftest(veri_arima)



tahmin_box<- veri_arima[["fitted"]]
hata_box<- veri_arima[["residuals"]]

plot( window(veri_ts), 
      xlab="Zaman (Y?l)", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin_box) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(X7_b_uygulama)),
                   expression(paste(Tahmin))),
       lwd=c(2,2),lty=c(1,3), cex=0.7, col=c(4,2))


ongoru<- forecast(veri_arima , h=5)

ongoru



# Öngörüyü yap
veri_arima <- Arima(veri_ts, order = c(1,1,0), seasonal = c(1,1,0), include.constant = TRUE)
summary(veri_arima)
coeftest(veri_arima)

ongoru <- forecast(veri_arima, h = 5)
ongoru
# Gerçek veri ve öngörüleri içeren bir veri seti oluştur
gercek_ve_ongoru <- c(veri_ts, ongoru$mean)

# Zaman serisi grafiğini çiz
plot(gercek_ve_ongoru, type = "l", col = "blue", main = "Gerçek ve Öngörü Değerler", ylab = "Değerler")

# Öngörüleri yeşil renkte çizgi olarak grafik üzerine ekleyin
lines(length(veri_ts) + 1:length(ongoru$mean), ongoru$mean, col = "green", type = "l")

# Legend ekleyin
legend("topleft", legend = c("Gerçek Değerler", "Öngörü"), col = c("blue", "green"), lty = 1)

hata_arima<- veri_arima[["residuals"]]

Box.test (hata, lag = 42, type = "Ljung")

checkresiduals(veri_arima)

Acf(hata_arima,main="Hata", lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(hata_arima,main="Hata",lag.max = 42, ylim=c(-1,1), lwd=3)

library(stats)
LjungBoxTest (hata,k=2,StartLag=1, lag=42 )
# Box.test fonksiyonunu kullan
Box.test(hata, lag = 42, type = "Ljung-Box")



####################### box jenkins ile tahmin

veri_arima <- Arima(veri_ts, order = c(1,1,0), seasonal = c(1,1,0), include.constant = TRUE)
summary(veri_arima)
coeftest(veri_arima)
#95.42
veri_arima2 <- Arima(veri_ts, order = c(1,1,0), seasonal = c(0,1,0), include.constant = TRUE)
summary(veri_arima2)#100.76
coeftest(veri_arima2)

veri_arima3 <- Arima(veri_ts, order = c(1,1,0), seasonal = c(0,1,1), include.constant = TRUE)
summary(veri_arima3)#82.59
coeftest(veri_arima3)

veri_arima4 <- Arima(veri_ts, order = c(1,1,0), seasonal = c(1,1,1), include.constant = TRUE)
summary(veri_arima4)#86.52
coeftest(veri_arima4)


tahmin_arima<- veri_arima3[["fitted"]]
hata_arima<- veri_arima3[["residuals"]]

plot( window(veri_ts), 
      xlab="Zaman", ylab="",lty=1, col=4, lwd=2)
lines( window(tahmin_arima) ,lty=3,col=2,lwd=3)
legend("topleft",c(expression(paste(CO2_PPM)),
                   expression(paste(Tahmin))),
       lwd=c(2,2),lty=c(1,3), cex=0.7, col=c(4,2))



Box.test (hata_arima, lag = 42, type = "Ljung")
checkresiduals(veri_arima3)
Acf(hata_arima,main="Hata", lag.max = 42,  ylim=c(-1,1), lwd=3)
Pacf(hata_arima,main="Hata",lag.max = 42, ylim=c(-1,1), lwd=3)
Box.test(hata_arima, lag = 42, type = "Ljung-Box")


ongoru_arima<- forecast(veri_arima3 , h=5)
ongoru_arima

# Gerçek veri ve öngörüleri içeren bir veri seti oluştur
gercek_ve_ongoru <- c(veri_ts, ongoru_arima$mean)

# Zaman serisi grafiğini çiz
plot(gercek_ve_ongoru, type = "l", col = "blue", main = "Gerçek ve Öngörü Değerler", ylab = "Değerler")

# Öngörüleri yeşil renkte çizgi olarak grafik üzerine ekleyin
lines(length(veri_ts) + 1:length(ongoru_arima$mean), ongoru_arima$mean, col = "green", type = "l")

# Legend ekleyin
legend("topleft", legend = c("Gerçek Değerler", "Öngörü"), col = c("blue", "green"), lty = 1)



#https://app.datacamp.com/learn/courses/arima-models-in-python

