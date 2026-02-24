CREATE DATABASE IF NOT EXISTS airbnb;
USE airbnb;
/*
1. Guest
*/
DROP TABLE IF EXISTS Guest;

CREATE TABLE Guest (
    guestID CHAR(5) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL,
    joinYear INT NOT NULL,
    joinMonth INT NOT NULL,
    joinDay INT NOT NULL,
    currentAvgRating DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (guestID));

INSERT INTO Guest
(guestID, firstName, lastName, email, joinYear, joinMonth, joinDay, currentAvgRating)
VALUES
('G0001','Han','Lu','luhan777@qq.com',2022,1,1,4.9),
('G0002','Leon','Kennedy','leon.kennedy@rpdmail.com',2022,1,12,4.5),
('G0003','Ada','Wong','ada.wong@umbrella-inc.com',2022,2,12,4.9),
('G0004','Claire','Redfield','claire.redfield@brightmail.com',2022,3,5,4.8),
('G0005','Chris','Redfield','chris.redfield@bsaa.net',2022,4,21,4.4),
('G0006','Xinghui','Shen','shenxinghui1016@qq.com',2022,5,18,4.7),
('G0007','Shen','Li','lishen0905@qq.com',2022,6,18,4.7),
('G0008','Yu','Qi','qiyu0306@qq.com',2022,7,18,4.7),
('G0009','Che','Qin','qinche0418@qq.com',2022,10,16,4.7),
('G0010','Yizhou','Xia','xiayizhou0613@qq.com',2022,12,5,4.7);

SELECT DISTINCT count(*) FROM Guest;



/*
2. GuestPhone
*/
DROP TABLE IF EXISTS GuestPhone;

CREATE TABLE GuestPhone (
    guestID CHAR(5) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL,
    PRIMARY KEY (guestID, phoneNumber),
    FOREIGN KEY (guestID) REFERENCES Guest(guestID));
    
INSERT INTO GuestPhone (guestID, phoneNumber) VALUES
('G0001', '8613864237810'),
('G0002', '12025549713'),
('G0003', '13106584329'),
('G0003', '19174368205'),
('G0004', '14087321658'),
('G0005', '17148450962'),
('G0006', '8615690854421'),
('G0007', '8613177269534'),
('G0007', '8613984726501'),
('G0008', '8618950483667'),
('G0008', '8615079362845'),
('G0008', '8618672594138'),
('G0009', '8614723915802'),
('G0010', '8617835640975');

SELECT * FROM GuestPhone;



/*
3. Host
*/
DROP TABLE IF EXISTS Host;

CREATE TABLE Host (
    hostID CHAR(5) NOT NULL,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    introduction VARCHAR(400) NOT NULL,
    email VARCHAR(100) NOT NULL,
    joinYear INT NOT NULL,
    joinMonth INT NOT NULL,
    joinDay INT NOT NULL,
    PRIMARY KEY (hostID));
    
INSERT INTO Host
(hostID, firstName, lastName, introduction, email, joinYear, joinMonth, joinDay)
VALUES
('H0001','Duffy','Bearington',
 'I’m Duffy, a warmhearted traveler bear who loves sharing cozy seaside homes with friends.',
 'duffy.bearington@disneyresort.com',2021,3,14),
('H0002','ShellieMay','Honeywell',
 'Hi, I’m ShellieMay — I host charming pastel cottages filled with love and handmade touches.',
 'shelliemay.home@yahoo.com',2021,8,7),
('H0003','StellaLou','Starbelle',
 'Hello! I’m StellaLou, a dancer bunny hosting graceful studios with soft lights and mirrors.',
 'stellalou.ballet.fr@gmail.com',2022,1,29),
('H0004','LinaBell','Foxworth',
 'I’m LinaBell, a clever fox who loves hosting curious guests in nature-inspired cabins.',
 'linabell.discovery.cn@163.com',2021,9,2),
('H0005','Cinnamoroll','Skypuff',
 'I’m Cinnamoroll, your cloud-loving puppy host — come relax above the city lights.',
 'cinnamoroll.sky@gmail.com',2022,1,25),
('H0006','Pompom','Purinton',
 'Welcome! I’m Pompompurin, a laid-back golden retriever who hosts sunny yellow rooms.',
 'pompompurin.smile@gmail.com',2021,6,12),
('H0007','Kuromi','Mischief',
 'Hey there! I’m Kuromi — my gothic loft blends charm, chaos, and a dash of mischief.',
 'kuromi.rebel@outlook.com',2021,10,30),
('H0008','Cappy','Barrows',
 'Hello! I’m Cappy Barrows, a relaxed capybara who hosts tranquil riverside cabins with natural hot baths.',
 'cappy.barrows@gmail.com',2021,2,15),
('H0009','Chinchilla','Willowfur',
 'Hi, I’m Chinchilla — a soft-spoken chinchilla offering peaceful hillside stays with fluffy blankets and calm views.',
 'ilovetreats@gmail.com',2017,7,11),
('H0010','Ginny','Pigsworth',
 'Welcome! I’m Ginny Pigsworth, your friendly guinea pig host with warm tea, cozy corners, and cheerful company.',
 'ginny.pigsworth@outlook.com',2021,5,9);

SELECT * FROM Host;



/*
4. HostPhone
*/
DROP TABLE IF EXISTS HostPhone;

CREATE TABLE HostPhone (
    hostID      CHAR(5)      NOT NULL,
    phoneNumber VARCHAR(15)  NOT NULL,
    PRIMARY KEY (hostID, phoneNumber),
    FOREIGN KEY (hostID) REFERENCES Host(hostID));

INSERT INTO HostPhone (hostID, phoneNumber) VALUES
('H0001', '12025548973'),
('H0001', '13107864215'),
('H0002', '14087539126'),
('H0003', '15038924761'),
('H0004', '8613894726508'),
('H0004', '8615073926481'),
('H0004', '8618685402739'),
('H0005', '819036572481'),
('H0006', '818045963217'),
('H0007', '817056428390'),
('H0008', '16028574390'),
('H0009', '17034589217'),
('H0009', '18025647318'),
('H0010','19017836425'),
('H0010','14156283907'),
('H0010','17148450692');

SELECT * FROM HostPhone;



/*
5. Listing
*/
DROP TABLE IF EXISTS Listing;

CREATE TABLE Listing (
    listingID CHAR(5) NOT NULL,
    currentAvgRating  DECIMAL(3,2) NOT NULL,
    latitude DECIMAL(8,5)  NOT NULL,
    longitude DECIMAL(8,5)  NOT NULL,
    PRIMARY KEY (listingID));
    
INSERT INTO Listing
(listingID, currentAvgRating, latitude, longitude)
VALUES
('L0001', 3.56, 42.65789, -73.75370),
('L0002', 4.75, 42.65222, -73.76724),
('L0003', 4.52, 42.64615, -73.75966),
('L0004', 4.73, 42.65222, -73.76724),
('L0005', 4.79, 42.65559, -73.76506),
('L0006', 4.57, 42.64734, -73.75851),
('L0007', 4.83, 42.66078, -73.80553),
('L0008', 4.96, 42.67567, -73.82438),
('L0009', 4.81, 42.67583, -73.78297),
('L0010', 4.83, 42.65154, -73.76867);

SELECT * FROM Listing;



/*
6. Listing_location
*/
DROP TABLE IF EXISTS Listing_location;

CREATE TABLE Listing_location (
    latitude DECIMAL(8,5) NOT NULL,
    longitude DECIMAL(8,5) NOT NULL,
    zipcode CHAR(5) NOT NULL,
    city VARCHAR(40) NOT NULL,
    state VARCHAR(40) NOT NULL,
    country VARCHAR(40) NOT NULL,
    streetName VARCHAR(100) NOT NULL,
    PRIMARY KEY (latitude, longitude));

INSERT INTO Listing_location
(latitude, longitude, zipcode, city, state, country, streetName)
VALUES
(42.65789, -73.75370, '85201', 'Mesa',        'Arizona',    'USA', '45 Main St'),
(42.65328, -73.79725, '90077', 'Los Angeles', 'California', 'USA', '78 Sunset Blvd'),
(42.64615, -73.75966, '89444', 'Wellington',  'Nevada',     'USA', '101 Desert Rd'),
(42.65222, -73.76724, '79029', 'Dumas',       'Texas',      'USA', '222 Pine Ave'),
(42.65559, -73.76506, '33139', 'Miami',       'Florida',    'USA', '333 Ocean Dr'),
(42.64734, -73.75851, '81505', 'Aspen',       'Colorado',   'USA', '789 Aspen Ln'),
(42.66078, -73.80553, '85927', 'Mesa',        'Arizona',    'USA', '45 Main St'),
(42.67567, -73.82438, '90077', 'Los Angeles', 'California', 'USA', '78 Sunset Blvd'),
(42.67583, -73.78297, '89444', 'Wellington',  'Nevada',     'USA', '101 Desert Rd'),
(42.65154, -73.76867, '78361', 'Hebbronville','Texas',      'USA', '222 Pine Ave');

SELECT * FROM Listing_location;



/*
7. AmenityCategory
*/
DROP TABLE IF EXISTS AmenityCategory;

CREATE TABLE AmenityCategory (
    AmenitycategoryID CHAR(5) NOT NULL,
    categoryName VARCHAR(50) NOT NULL,
    PRIMARY KEY (AmenitycategoryID));

INSERT INTO AmenityCategory
(AmenitycategoryID, categoryName)
VALUES
('ac001', 'Home safety'),
('ac002', 'Bedroom'),
('ac003', 'Air conditioning'),
('ac004', 'Access service'),
('ac005', 'Entertainment'),
('ac006', 'Entertainment'),
('ac007', 'Bedroom'),
('ac008', 'Workspace'),
('ac009', 'Heating & cooling'),
('ac010', 'Kitchen & dining');

SELECT * FROM AmenityCategory; 



/*
8. Amendity
*/
DROP TABLE IF EXISTS Amenity;

CREATE TABLE Amenity (
    amenityID CHAR(6) NOT NULL,
    amenityName VARCHAR(80) NOT NULL,
    AmenitycategoryID CHAR(5) NOT NULL,
    PRIMARY KEY (amenityID),
    FOREIGN KEY (AmenitycategoryID) REFERENCES AmenityCategory(AmenitycategoryID));

INSERT INTO Amenity
(amenityID, amenityName, AmenitycategoryID)
VALUES
('Am0001', 'Smoke alarm', 'ac001'),
('Am0002', 'Essentials','ac002'),
('Am0003', 'Heating','ac003'),
('Am0004', 'Smart lock','ac004'),
('Am0005', 'HDTV with standard cable', 'ac005'),
('Am0006', 'Apple TV','ac006'),
('Am0007', 'Hangers', 'ac007'),
('Am0008', 'Dedicated workspace','ac008'),
('Am0009', 'Window AC unit','ac009'),
('Am0010', 'Gas stove','ac010');

SELECT * FROM Amenity;



/*
9. Attraction
*/
DROP TABLE IF EXISTS Attraction;

CREATE TABLE Attraction (
    attractionID CHAR(6) NOT NULL,
    attractionName VARCHAR(80) NOT NULL,
    streetName VARCHAR(100) NOT NULL,
    zipcode CHAR(5)  NOT NULL,
    PRIMARY KEY (attractionID)
);

INSERT INTO Attraction
(attractionID, attractionName, streetName, zipcode)
VALUES
('AT0001', 'Downtown',  'Downtown Albany', '12224'),
('AT0002', 'Palace theater', '19 Clinton Ave', '12207'),
('AT0003', 'Washington Park','Washington Park Rd','12203'),
('AT0004', 'Lark Street', 'Lark St', '12208'),
('AT0005', 'Empire Plaza', '100 S Mall Arterial', '12242'),
('AT0006', 'Albany Med Offices', '43 New Scotland Ave', '12208'),
('AT0007', 'The State Capital',  'State St. and, Washington Ave','12224'),
('AT0008', 'NYS Museum', '222 Madison Ave', '12230'),
('AT0009', 'Governor''s Mansion','138 Eagle St', '12202');

SELECT * FROM Attraction;



/*
10. Booking_detail
*/
DROP TABLE IF EXISTS Booking_detail;

CREATE TABLE Booking_detail (
    bookingID CHAR(5) NOT NULL,
    totalPrice INT NOT NULL,
    checkinYear INT NOT NULL,
    checkinMonth INT NOT NULL,
    checkinDay INT NOT NULL,
    checkinHour INT NOT NULL,
    checkoutYear INT NOT NULL,
    checkoutMonth INT NOT NULL,
    checkoutDay INT NOT NULL,
    checkoutHour INT NOT NULL,
    PRIMARY KEY (bookingID));

INSERT INTO Booking_detail
(bookingID, totalPrice,
 checkinYear, checkinMonth, checkinDay, checkinHour,
 checkoutYear, checkoutMonth, checkoutDay, checkoutHour)
VALUES
('B0001', 120, 2022, 1, 23, 5,  2022, 1, 30, 13),
('B0002', 135, 2022, 1, 27, 18, 2022, 2, 21, 4),
('B0003', 150, 2022, 3,  1, 10, 2022, 3, 14, 18),
('B0004', 165, 2022, 3, 28, 21, 2022, 4, 15, 9),
('B0005', 185, 2022, 5, 25, 7,  2022, 5, 29, 22),
('B0006', 210, 2022, 6, 29, 14, 2022, 7, 22, 22),
('B0007', 230, 2022, 7, 30, 3,  2022, 8, 8, 15),
('B0008', 240, 2022, 8, 26, 12, 2022, 9, 22, 1),
('B0009', 160, 2022, 11,22, 19, 2022,12, 8, 11),
('B0010', 275, 2022, 12,28, 9,  2023, 1, 2, 20);

SELECT * FROM Booking_detail;



/*
11. Guest_Concern_Report
*/
DROP TABLE IF EXISTS Guest_Concern_Report;

CREATE TABLE Guest_Concern_Report (
    reportID CHAR(6) NOT NULL,
    guestID CHAR(5) NOT NULL,
    reportReason VARCHAR(100) NOT NULL,
    country VARCHAR(40) NOT NULL,
    state VARCHAR(40) NOT NULL,
    streetName  VARCHAR(100) NOT NULL,
    zipCode CHAR(5) NOT NULL,
    year SMALLINT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    hour INT NOT NULL, 
    minute INT NOT NULL,
    PRIMARY KEY (reportID),
    FOREIGN KEY (guestID) REFERENCES Guest(guestID));

INSERT INTO GUEST_CONCERN_REPORT
(guestID, reportID, reportReason, country, state, streetName, zipCode, year, month, day, hour, minute)
VALUES
('G0001','GR0001','Noise complint','USA','Arizona','45 Main St','85721',2022,1,25,8,33),
('G0002','GR0002','Cleaning issue','USA','California','78 Sunset Blvd','90001',2022,2,3,9,15),
('G0003','GR0003','Lake check-in','USA','Nevada','101 Desert Rd','89109',2022,2,15,22,48),
('G0004','GR0004','Broken air conditioner','USA','Texas','222 Pine Ave','73301',2022,4,2,14,20),
('G0005','GR0005','Wi-fi not working','USA','Florida','333 Ocean Dr','33139',2022,5,27,13,18),
('G0006','GR0006','No hot water','USA','Colorado','789 Aspen Ln','80014',2022,7,9,2,41),
('G0001','GR0007','Noise from neighbors','USA','Arizona','45 Main St','85721',2022,1,28,19,12),
('G0002','GR0008','Host not reponsive','USA','California','78 Sunset Blvd','90001',2022,2,15, 22, 48),
('G0003','GR0009','Cleaning issue','USA','Nevada','101 Desert Rd','89109',2022,3,11,16,29),
('G0004','GR0010','Bad smell','USA','Texas','222 Pine Ave','73301',2022,4,11,6,57);

SELECT * FROM Guest_Concern_Report;



/*
12. Host_Concern_Report
*/
DROP TABLE IF EXISTS Host_Concern_Report;

CREATE TABLE Host_Concern_Report (
    reportID CHAR(6) NOT NULL,
    hostID CHAR(5) NOT NULL,
    reportReason VARCHAR(100)  NOT NULL,
    country VARCHAR(40) NOT NULL,
    state VARCHAR(40) NOT NULL,
    streetName VARCHAR(100) NOT NULL,
    zipCode CHAR(5) NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day  INT NOT NULL,
    hour INT NOT NULL,
    minute INT NOT NULL,
    PRIMARY KEY (reportID),
    FOREIGN KEY (hostID) REFERENCES Host(hostID));
    
INSERT INTO Host_Concern_Report
(hostID, reportID, reportReason, country, state, streetName, zipCode,
 year, month, day, hour, minute)
VALUES
('H0001','HR0001','Guest damaged property','USA','Arizona','12 Hillcrest Ave','85721',2022,2,2,4,51),
('H0001','HR0002','Guest left late','USA','Arizona','12 Hillcrest Ave','85721', 2022,2,4,16,39),
('H0002','HR0003','Excessive noise from guests','USA','California','245 Ocean Blvd','90001',2022,2,25,22,5),
('H0003','HR0004','Smoking in property','USA','Nevada','18 Desert Dr','89109', 2022,3,19,8,42),
('H0003','HR0005','Trash not disposed','USA','Nevada','18 Desert Dr','89109',2022,3,20,15,33),
('H0004','HR0006','Unauthorized pet','USA','Texas','451 Oak St','73301', 2022,4,17,2,28),
('H0005','HR0007','Broken furniture','USA','Florida','789 Palm Rd','33139', 2022,6,2,10,41),
('H0005','HR0008','Stolen towels','USA','Florida','789 Palm Rd','33139', 2022,6,4,5,26),
('H0002','HR0009','Key not returned','USA','California','245 Ocean Blvd','90001', 2022,2,27,11,14),
('H0004','HR0010','Water leak reported late','USA','Texas','451 Oak St','73301', 2022,4,21,23,57);

SELECT * FROM Host_Concern_Report;



/*
13. Booking_Aircover
*/
DROP TABLE IF EXISTS Booking_Aircover;

CREATE TABLE Booking_Aircover (
    bookingID CHAR(5) NOT NULL,
    policyNumber CHAR(5) NOT NULL,
    policyStartYear INT NOT NULL,
    policyStartMonth INT NOT NULL,
    policyStartDay INT NOT NULL,
    policyStartHour INT NOT NULL,
    policyStartMinute INT NOT NULL,
    policyEndYear INT NOT NULL,
    policyEndMonth INT NOT NULL,
    policyEndDay INT NOT NULL,
    policyEndHour INT NOT NULL,
    policyEndMinute INT NOT NULL,
    PRIMARY KEY (bookingID, policyNumber),
    FOREIGN KEY (bookingID) REFERENCES Booking_detail(bookingID));

INSERT INTO Booking_Aircover
(bookingID, policyNumber, policyStartYear, policyStartMonth, policyStartDay, policyStartHour, policyStartMinute, 
policyEndYear,   policyEndMonth,   policyEndDay, policyEndHour , policyEndMinute)
VALUES
('B0001','P0001',2022,1,23,5,14,  2022,1,30,13,22),
('B0002','P0002',2022,1,27,18,42, 2022,2,21,4,57),
('B0003','P0003',2022,3,1,10,3,   2022,3,14,18,11),
('B0004','P0004',2022,3,28,21,56, 2022,4,15,9,36),
('B0005','P0005',2022,5,25,7,40,  2022,5,29,22,3),
('B0006','P0006',2022,6,29,14,27, 2022,7,22,6,49),
('B0007','P0007',2022,7,30,3,51,  2022,8,8,15,27),
('B0008','P0008',2022,8,26,12,9,  2022,9,22,1,54),
('B0009','P0009',2022,11,22,19,33,2022,12,8,11,5),
('B0010','P0010',2022,12,28,9,48, 2023,1,2,20,42);

SELECT * FROM Booking_Aircover;



/*
14. Listing_Aircover
*/
DROP TABLE IF EXISTS Listing_Aircover;

CREATE TABLE Listing_Aircover (
    listingID CHAR(5) NOT NULL,
    policyNumber CHAR(5) NOT NULL,
    macStart DATE NULL,
    macEnd DATE NULL,
    policyStartYear INT NOT NULL,
    policyStartMonth INT NOT NULL,
    policyStartDay INT NOT NULL,
    policyEndYear INT NOT NULL,
    policyEndMonth INT NOT NULL,
    policyEndDay INT NOT NULL,
    PRIMARY KEY (listingID, policyNumber),
    FOREIGN KEY (listingID) REFERENCES Listing(listingID));

INSERT INTO Listing_Aircover
(listingID, policyNumber, macStart, macEnd,
 policyStartYear, policyStartMonth, policyStartDay,
 policyEndYear, policyEndMonth, policyEndDay)
VALUES
('L0001','P0001','2021-03-14','2031-03-14',2021,3,14,2031,3,14),
('L0002','P0002','2021-08-07','2031-08-07',2021,8,7,2031,8,7),
('L0003','P0003','2022-01-29','2032-01-29',2022,1,29,2032,1,29),
('L0004','P0004','2021-09-02','2031-09-02',2021,9,2,2031,9,2),
('L0005','P0005','2022-01-25','2032-01-25',2022,1,25,2032,1,25),
('L0006','P0006','2021-06-12','2031-06-12',2021,6,12,2031,6,12),
('L0007','P0007','2021-10-30','2031-10-30',2021,10,30,2031,10,30),
('L0008','P0008','2021-02-15','2031-02-15',2021,2,15,2031,2,15),
('L0009','P0009','2021-07-11','2031-07-11',2021,7,11,2031,7,11),
('L0010','P0010','2021-05-09','2031-05-09',2021,5,9,2031,5,9);

SELECT * FROM Listing_Aircover;



/*
15. Review
*/
DROP TABLE IF EXISTS Review;

CREATE TABLE Review (
    bookingID CHAR(5) NOT NULL,
    forGuestComment VARCHAR(200) NOT NULL,
    forGuestRating INT NOT NULL,
    forListingComment VARCHAR(200)  NOT NULL,
    forListingRating INT NOT NULL,
    PRIMARY KEY (bookingID),
    FOREIGN KEY (bookingID) REFERENCES Booking_detail(bookingID)
);

INSERT INTO Review
(bookingID, forGuestComment, forGuestRating, forListingComment, forListingRating)
VALUES
('B0001','respectful, checked in and out on time',5,'Great location, thanks!',5),
('B0002','did not respond quickly',4,'This made my birthday',5),
('B0003','checked out late',3,'Thanks for going above and beyond and helping with the garage',5),
('B0004','Great guest, even took off bed sheets and left dishes washed',5,'Bedbugs!!',1),
('B0005','Left food in fridge, but everything else was ok',4,'Great spot to stay, center of town',5),
('B0006','So happy with these guests. Please come again!',5,'This was so convenient. thanks for communicating',5),
('B0007','Let me know your eta next time',4,'Hard to find the gate!',4),
('B0008','Good',5,'Will come again!',5),
('B0009','Neighbors got upset because music was too loud',3,'Had the best time.',5),
('B0010','Come again!',5,'Wifi didnt work!',3);

SELECT * FROM Review;



/*
16. Payment
*/
DROP TABLE IF EXISTS Payment;

CREATE TABLE Payment (
    paymentID CHAR(5) NOT NULL,
    bookingID CHAR(5) NOT NULL,
    days INT NOT NULL,
    totalPaymentUSD DECIMAL(10,2) NOT NULL,
    paymentMethod VARCHAR(20) NOT NULL,
    macDate DATETIME NOT NULL,
    year  INT NOT NULL,month INT NOT NULL, 
    Day INT NOT NULL,
    hour INT NOT NULL,
    minute INT NOT NULL,
    PRIMARY KEY (paymentID),
    FOREIGN KEY (bookingID) REFERENCES Booking_detail(bookingID));

INSERT INTO Payment
(paymentID, bookingID, days, totalPaymentUSD, paymentMethod,macDate, year, month, day, hour, minute)
VALUES
('C0001','B0001',7,  350.43,'visa',    '2022-01-11 14:33:00',2018,1, 9,13,45),
('C0002','B0002',25,2310.21,'master',  '2022-01-19 03:22:00',2020,1,10,18, 2),
('C0003','B0003',13, 450.89,'discover','2022-02-21 16:09:00',2021,2, 4,12,34),
('C0004','B0004',18,1090.90,'visa',    '2022-03-15 09:48:00',2022,3,13,21,26),
('C0005','B0005',4,  276.67,'master',  '2022-05-07 18:12:00',2023,1,10,17,49),
('C0006','B0006',22,1987.20,'master',  '2022-06-05 07:26:00',2024,4, 9,20,15),
('C0007','B0007',9,  681.90,'visa',    '2022-07-07 22:41:00',2025,7,12,23,36),
('C0008','B0008',27,2790.67,'discover','2022-08-12 11:03:00',2025,5,15,13,21),
('C0009','B0009',16,1110.12,'visa',    '2022-11-05 04:57:00',2025,8,17,16, 1),
('C0010','B0010',5,  678.12,'visa',    '2022-12-17 20:29:00',2025,10,2,21,14);

SELECT * FROM Payment;



/*
17. Host_Has_Listing
*/
DROP TABLE IF EXISTS Host_Has_Listing;

CREATE TABLE Host_Has_Listing (
    hostID CHAR(5) NOT NULL,
    listingID CHAR(5) NOT NULL,
    PRIMARY KEY (hostID, listingID),
    FOREIGN KEY (hostID) REFERENCES Host(hostID),
    FOREIGN KEY (listingID) REFERENCES Listing(listingID));

INSERT INTO Host_Has_Listing (hostID, listingID) VALUES
('H0001', 'L0001'),
('H0001', 'L0002'),
('H0002', 'L0003'),
('H0003', 'L0004'),
('H0003', 'L0005'),
('H0004', 'L0006'),
('H0005', 'L0007'),
('H0005', 'L0008'),
('H0002', 'L0009'),
('H0004', 'L0010');

SELECT * FROM Host_Has_Listing;



/*
18. Listing_Has_Amenity
*/
DROP TABLE IF EXISTS Listing_Has_Amenity;

CREATE TABLE Listing_Has_Amenity (
    listingID CHAR(5) NOT NULL,
    amenityID CHAR(6) NOT NULL,
    PRIMARY KEY (listingID, amenityID),
    FOREIGN KEY (listingID) REFERENCES Listing(listingID),
    FOREIGN KEY (amenityID) REFERENCES Amenity(amenityID)
);

INSERT INTO Listing_Has_Amenity (listingID, amenityID) VALUES
('L0001','Am0001'),
('L0002','Am0002'),
('L0003','Am0003'),
('L0004','Am0001'),
('L0005','Am0004'),
('L0006','Am0002'),
('L0007','Am0005'),
('L0008','Am0001'),
('L0009','Am0006'),
('L0010','Am0005');

SELECT * FROM Listing_Has_Amenity;



/*
19. Listing_Is_Near_To_Attraction
*/
DROP TABLE IF EXISTS Listing_Is_Near_To_Attraction;

CREATE TABLE Listing_Is_Near_To_Attraction (
    listingID    CHAR(5) NOT NULL,
    attractionID CHAR(6) NOT NULL,
    PRIMARY KEY (listingID, attractionID),
    FOREIGN KEY (listingID)    REFERENCES Listing(listingID),
    FOREIGN KEY (attractionID) REFERENCES Attraction(attractionID));

INSERT INTO Listing_Is_Near_To_Attraction (listingID, attractionID) VALUES
('L0001','AT0001'),
('L0002','AT0002'),
('L0003','AT0003'),
('L0004','AT0002'),
('L0005','AT0004'),
('L0006','AT0005'),
('L0007','AT0003'),
('L0008','AT0001'),
('L0009','AT0001'),
('L0010','AT0005');

SELECT * FROM Listing_Is_Near_To_Attraction;



/*
20. Booking
*/
DROP TABLE IF EXISTS Booking;

CREATE TABLE Booking (
    bookingID CHAR(5) NOT NULL,
    guestID CHAR(5) NOT NULL,
    listingID CHAR(5) NOT NULL,
    PRIMARY KEY (bookingID),
    FOREIGN KEY (bookingID) REFERENCES Booking_detail(bookingID),
    FOREIGN KEY (guestID)   REFERENCES Guest(guestID),
    FOREIGN KEY (listingID) REFERENCES Listing(listingID));

INSERT INTO Booking (guestID, listingID, bookingID) VALUES
('G0001','L0001','B0001'),
('G0002','L0002','B0002'),
('G0003','L0003','B0003'),
('G0004','L0004','B0004'),
('G0005','L0005','B0005'),
('G0006','L0006','B0006'),
('G0007','L0007','B0007'),
('G0008','L0008','B0008'),
('G0009','L0009','B0009'),
('G0010','L0010','B0010');

SELECT * FROM Booking;
