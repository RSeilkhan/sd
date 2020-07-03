-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 10 2020 г., 17:30
-- Версия сервера: 10.4.11-MariaDB
-- Версия PHP: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `fin`
--

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

CREATE TABLE `city` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `t_comments`
--

CREATE TABLE `t_comments` (
  `id` bigint(20) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `news_post_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_comments`
--

INSERT INTO `t_comments` (`id`, `comment`, `post_date`, `author_id`, `news_post_id`) VALUES
(1, 'My name is Lalita', '2020-05-31 18:16:32', 16, 1),
(2, 'Its my first post', '2020-05-31 19:37:49', 16, 3),
(3, 'Good post', '2020-05-31 21:06:04', 1, 3),
(4, 'SYES', '2020-05-31 21:06:11', 1, 3),
(5, 'hello its good post', '2020-06-01 07:02:54', 1, 2),
(6, 'hello', '2020-06-01 07:55:55', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `t_friends`
--

CREATE TABLE `t_friends` (
  `id` bigint(20) NOT NULL,
  `friend_id` bigint(20) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_friends`
--

INSERT INTO `t_friends` (`id`, `friend_id`, `is_active`, `owner_id`) VALUES
(1, 5, b'1', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `t_newspost`
--

CREATE TABLE `t_newspost` (
  `id` bigint(20) NOT NULL,
  `content` varchar(600) DEFAULT NULL,
  `post_date` datetime DEFAULT NULL,
  `short_content` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_newspost`
--

INSERT INTO `t_newspost` (`id`, `content`, `post_date`, `short_content`, `title`, `author_id`, `image`) VALUES
(1, 'my post', '2020-05-31 17:56:53', 'its ', 'hello', 2, 'https://s.yimg.com/ny/api/res/1.2/12UU2JphAsbxTTDca.7QFQ--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9MTA4MDtoPTcxNg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2019-11/7b5b5330-112b-11ea-a77f-7c019be7ecae'),
(2, 'asdasdasd', '2020-05-31 19:18:59', 'sdads', 'asdsadasd', 16, 'https://images.befunky.com/wp/wp-2014-08-milky-way-1023340_1280.jpg?auto=format&fm=jpg&q=75&w=1184&ixlib=js-1.4.1'),
(3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ducimus, vero, obcaecati, aut, error quam sapiente nemo saepe quibusdam sit excepturi nam quia corporis eligendi eos magni recusandae laborum minus inventore?', '2020-05-31 19:29:42', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 'Lorem ipsum dolor sit amet', 16, 'https://assets.justinmind.com/wp-content/uploads/2018/11/Lorem-Ipsum-alternatives.png'),
(4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pharetra varius quam sit amet vulputate. \r\nQuisque mauris augue, molestie tincidunt condimentum vitae, gravida a libero. Aenean sit amet felis \r\ndolor, in sagittis nisi. Sed ac orci quis tortor imperdiet venenatis. Duis elementum auctor accumsan. \r\nAliquam in felis sit amet augue.', '2020-05-31 21:03:38', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 'Lorem ipsum dolor sit amet', 1, 'https://timesofindia.indiatimes.com/thumb/msid-73792188,width-1200,height-900,resizemode-4/.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `t_roles`
--

CREATE TABLE `t_roles` (
  `id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_roles`
--

INSERT INTO `t_roles` (`id`, `description`, `role`) VALUES
(1, 'User', 'ROLE_USER'),
(2, 'Admin', 'ROLE_ADMIN'),
(3, 'Moder', 'ROLE_MODERATOR');

-- --------------------------------------------------------

--
-- Структура таблицы `t_users`
--

CREATE TABLE `t_users` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `birthday` int(11) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `tel_number` varchar(255) DEFAULT NULL,
  `about` varchar(255) DEFAULT NULL,
  `avatar` varchar(500) NOT NULL,
  `city` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_users`
--

INSERT INTO `t_users` (`id`, `email`, `is_active`, `name`, `password`, `surname`, `birthday`, `gender`, `tel_number`, `about`, `avatar`, `city`) VALUES
(1, 'admin@gmail.com', b'1', 'Rakhat', '$2a$10$x1DgkRjpU7tW4L9cYP6uF.uC3KbNtDyXMt64GVbgh8efN6rDYE.m6', 'Seilkhan', 20, 'male', '87779776789', 'I\'m the developer', 'https://sun2.beeline-kz.userapi.com/vjLBrJHpTmND6IIcDjo2yOdhvKdsXA4vwutEOg/jBIjJe1sjZE.jpg', 'Almaty'),
(2, 'moder@gmail.com', b'1', 'Nurdaulet', '$2a$10$N5pBlwAKteU6TVv84fIv7ePrlReLzvOID60umoOMVMepdHrkPd.ca', 'Abishev', 21, 'male', '87074857799', 'I\'m a moder of this site', 'https://sun2.beeline-kz.userapi.com/XZh7nZKyhfsmQzavwP0_SXWDf8g1Sj-5BFG5-g/2exol1F3-a8.jpg', 'Almaty'),
(3, 'dana@gmail.com', b'1', 'Dana', '$2a$10$x1DgkRjpU7tW4L9cYP6uF.uC3KbNtDyXMt64GVbgh8efN6rDYE.m6', 'Berdikulova', 21, 'female', '87779542515', 'Searching for friends. I just want to find friends to have fun with them.', 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Jessica_Ennis_%28May_2010%29_cropped.jpg', 'Taraz'),
(16, 'lalala@gmail.com', b'1', 'Lalita', '$2a$10$8DSzSr.g4jHzy4MynBX/rOnq9ns5vtHC9Alwp4IiVQrAbwEV21bhe', 'Lalova', 18, 'female', '87018785245', 'Hello, my name is Lalita.\r\nI\'m a student in KazNU', 'https://timesofindia.indiatimes.com/thumb/msid-73792188,width-1200,height-900,resizemode-4/.jpg', 'Karagandy'),
(5, 'johnny_boy@gmail.com', b'1', 'Zhassulan', '$2a$10$ary51/eanNvWomjpPJRyJ.mJ49LYcE9U0WkRlZzPOVAooQ78AX6I6', 'Yegeubayev', 20, 'male', '87714579865', 'I\'m searching for LOVE.\r\nCall me girls, I\'m single', 'https://sun1.beeline-kz.userapi.com/2DYSNdRBB6_87LZrAe9HkAaPS7EDhODngBVXsw/xH8g1T5yA3A.jpg', 'Aktau'),
(6, 'doter@gmail.com', b'1', 'Randy', '$2a$10$vdNlVg3TdEzeQ8I17M1VR.qVA/WUYprThx6zWhSKLK6XOaM5Elp3K', 'Dandy', NULL, 'male', '87779877776', 'I\'m dota prof player.\r\nLooking for wife to five borth child', 'https://gamespot1.cbsistatic.com/uploads/scale_landscape/1551/15516851/2919239-screen%20shot%202015-08-09%20at%2010.49.01%20pm.jpg', 'Almaty'),
(8, 'ada@gmail.com', b'1', 'Ada', '$2a$10$.Ru5qRjC3WL4cdbNfuU6B.AZDwLaRupQUgv89O4tfECH7stAWHlpC', 'Nariko', 23, 'female', '87779877776', 'Everyone gets the famous \"Tell me about yourself\" question, but not every answers is the right one. Check out our 3-Step formula for an awesome answe', 'https://s1.1zoom.me/big3/20/Ada_Wong_Resident_Evil_2_2019_Brunette_girl_Glance_562631_3840x2160.jpg', 'Nur-Sultan'),
(9, 'wanda@gmail.com', b'1', 'Wanda', '$2a$10$HhRjRJ0Zup04PXUVLCnBcOiasEc2TF0Nn586J13K7xsajjScJ9lvW', 'Wano', 21, 'female', '87779877985', 'Everyone gets the famous \"Tell me about yourself\" question, but not every answers is the right one. Check out our 3-Step formula for an awesome answe', 'https://reellifebygrace.files.wordpress.com/2016/09/wanda-maximoff.jpg?w=700', 'Shymkent'),
(10, 'bitters@gmail.com', b'1', 'Bite', '$2a$10$b.Vo5FkEy60IDlcgFXhsheq4sRiDLXz0cCIB4RgWvHp0R99AzNWW.', 'Hero', 18, 'male', '8789984654123', 'Hero of this world', 'https://keyword-hero.com/wp-content/uploads/2017/04/Cart-Hero.png', 'Almaty'),
(11, 'today@gmail.com', b'1', 'Shyngys', '$2a$10$/0uuRQO09n3XKy3Wb2BsqOIoLHj/6E5JJgufdg6XCQuXriY4JOdWG', 'Teniz', 20, 'male', '87779776789', 'Anime boy, looking for own 2d chan', 'https://i7.pngguru.com/preview/994/418/496/anime-drawing-manga-neotokio3-music-manga-boy.jpg', 'Taraz'),
(12, 'zhassulan123@gmail.com', b'1', 'Zhassulan', '$2a$10$OZFY2SwaSRYI/iu4507Icu6Lo.ZHOfK4tyq13vyA/p2yajaQ7F03W', 'Yegeubayev', 121, 'male', '8777111111', '', 'https://i1.sndcdn.com/avatars-000495007683-zg65ko-t500x500.jpg', NULL),
(13, 'aa@gmailcom', b'1', 'rara', '$2a$10$ZJ7P8pZiuRvflnssLMWaBeosUnke7EjBJdhzny1U2ed7V/xYGELxC', 'rara', 123, 'male', '321', '13213adsad AWdasdads', 'https://i1.sndcdn.com/avatars-000495007683-zg65ko-t500x500.jpg', 'Karagandy'),
(17, 'zhindi@gmail.com', b'1', 'Rakhat', '$2a$10$YaBq71ZqpkHNnME5vhY5FeAL4J2ZMUxkGGpQTtnAtl0Hon/.JIPzW', 'password (zhindi@gmail.com)', 231, 'male', '87779776789', 'hello its about me', 'https://i1.sndcdn.com/avatars-000495007683-zg65ko-t500x500.jpg', 'Karagandy'),
(18, 'rakhat@gmail.com', b'1', 'password(rakhat@gmail.com)', '$2a$10$OtMUUPom.1z0pc0fcV/H..wfHXCBxRohWKPLYCd1vOrXZQAXmhWeG', 'Seilkhan', 21, 'male', '87779776789', 'hello its about me', 'https://i1.sndcdn.com/avatars-000495007683-zg65ko-t500x500.jpg', 'Shymkent'),
(19, 'image@gmail.com', b'1', 'Rakhat', '$2a$10$8hf9c6xcz3R8WGO.PNPq6.e28Y10y6X9JA4uM//52tbqNK.AZLeX6', 'password(image@gmail.com)', 21, 'male', '87779776789', 'hello its about me', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEhUQEBAVEBAPEBUVFRUVEA8QEBYPFRUWFxUVFRUYHSggGBolHRUXITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OFw8QGC0dHx8rLS0tLS0tLS0rLS0rLS0tLS0tLS0tLS0tLSstLS0tLS0rLS0tLS0tLS0tLS0tLS0rLf/AABEIAOEA4QMBIgACEQEDEQH/', 'Almaty'),
(20, 'checkimage@gmail.com', b'1', 'checkimage@gmail.com', '$2a$10$tEdlM8fX5Wn5NTxclwsCzOgQ/rkR4k.9dtu4Ra8kx.Oi3vPUi.S0i', 'Seilkhan', 21, 'male', '87779776789', 'hello its about me', 'https://sun2.beeline-kz.userapi.com/XZh7nZKyhfsmQzavwP0_SXWDf8g1Sj-5BFG5-g/2exol1F3-a8.jpg', 'Aktau'),
(21, 'kairat@mail.ru', b'1', 'Kairat', '$2a$10$udp6gCXp2OmxjSXBCJQXZuSOBAKz5aCMxP5bKhC1E66T.u.mIaKNO', 'Nurtas', 35, 'male', '87771117797', 'Almaty nights', 'https://mgorod.kz/wp-content/uploads/2013/06/kairatnurtas.kz_.jpg', 'Aktau'),
(22, 'moder2@gmail.com', b'1', 'Danny', '$2a$10$yWUbZcKmxacWiSWpnsS8..pQ0FY9VL.LKJJ/hLCEMS7IWHu/RUSSW', 'Phantom', NULL, NULL, '87771117797', NULL, '.../src/main/resources/templates/images/moder.jpg', 'Shymkent'),
(23, 'zoro@gmail.com', b'1', 'zoro@gmail.com', '$2a$10$6TN3sIHklyIgkELxq44IsOfEmwE3mYOOD2e9pgd4iuLGlTCR0tzeC', 'zoro@gmail.com', 23, 'male', 'zoro@gmail.com', 'zoro@gmail.com', 'https://w7.pngwing.com/pngs/695/106/png-transparent-roronoa-zoro-monkey-d-luffy-dracule-mihawk-one-piece-t-shirt-zoro-hand-manga-human.png', 'Shymkent'),
(24, 'mike@gmail.com', b'1', 'Mike', '$2a$10$.sW/1eRkAm75r6sHtHK/GeQQ1rQyWZQSzyiaRAPAynY81z7sX1hm.', 'Rio', 32, 'male', '87771117797', 'HERE WE GO', 'https://images.squarespace-cdn.com/content/v1/5005b235c4aa8b4d9760fd8b/1570754520079-KS163PTR957VFNAWKPE7/ke17ZwdGBToddI8pDm48kMXRibDYMhUiookWqwUxEZ97gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0luUmcNM2NMBIHLdYyXL-Jww_XBra4mrrAHD6FMA3bNKOBm5vyMDUBjVQdcIrt03OQ/mike-mchargue-6.jpg', 'Nur-Sultan');

-- --------------------------------------------------------

--
-- Структура таблицы `t_users_city`
--

CREATE TABLE `t_users_city` (
  `users_id` bigint(20) NOT NULL,
  `city_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `t_users_friends`
--

CREATE TABLE `t_users_friends` (
  `users_id` bigint(20) NOT NULL,
  `friends_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `t_users_roles`
--

CREATE TABLE `t_users_roles` (
  `users_id` bigint(20) NOT NULL,
  `roles_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `t_users_roles`
--

INSERT INTO `t_users_roles` (`users_id`, `roles_id`) VALUES
(1, 2),
(2, 3),
(3, 1),
(5, 1),
(6, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 3),
(23, 1),
(24, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `t_comments`
--
ALTER TABLE `t_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKhap1hu5fnn0sdipo6hfijsrok` (`author_id`),
  ADD KEY `FK2trfthoqwpm6dnl0pi0uy0lbk` (`news_post_id`);

--
-- Индексы таблицы `t_friends`
--
ALTER TABLE `t_friends`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `t_newspost`
--
ALTER TABLE `t_newspost`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKhworsf4fd9c3kbggd9knaloxd` (`author_id`);

--
-- Индексы таблицы `t_roles`
--
ALTER TABLE `t_roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `t_users`
--
ALTER TABLE `t_users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `t_users_city`
--
ALTER TABLE `t_users_city`
  ADD PRIMARY KEY (`users_id`,`city_id`),
  ADD KEY `FK89s27qn41kl8u53hfehn3tre` (`city_id`);

--
-- Индексы таблицы `t_users_friends`
--
ALTER TABLE `t_users_friends`
  ADD PRIMARY KEY (`users_id`,`friends_id`),
  ADD KEY `FKfer0vpd0w6ave4il4ka73jmfe` (`friends_id`);

--
-- Индексы таблицы `t_users_roles`
--
ALTER TABLE `t_users_roles`
  ADD PRIMARY KEY (`users_id`,`roles_id`),
  ADD KEY `FK9qf4n9htwf2hlfnqoucqmyeg9` (`roles_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `city`
--
ALTER TABLE `city`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `t_comments`
--
ALTER TABLE `t_comments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `t_friends`
--
ALTER TABLE `t_friends`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `t_newspost`
--
ALTER TABLE `t_newspost`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `t_roles`
--
ALTER TABLE `t_roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `t_users`
--
ALTER TABLE `t_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
