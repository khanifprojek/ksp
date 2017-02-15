-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 15, 2017 at 10:21 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ksp`
--

-- --------------------------------------------------------

--
-- Table structure for table `cicilan`
--

CREATE TABLE `cicilan` (
  `id` int(11) NOT NULL,
  `kode_nasabah` varchar(100) DEFAULT NULL,
  `pinjaman_id` int(11) DEFAULT NULL,
  `cicilan_ke` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `denda`
--

CREATE TABLE `denda` (
  `id` int(11) UNSIGNED NOT NULL,
  `kode_nasabah` varchar(100) DEFAULT NULL,
  `pinjaman_id` int(11) DEFAULT NULL,
  `cicilan_ke` int(11) DEFAULT NULL,
  `jumlah` float DEFAULT NULL,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `keanggotaan`
--

CREATE TABLE `keanggotaan` (
  `id` int(11) UNSIGNED NOT NULL,
  `jenis` varchar(100) DEFAULT NULL,
  `simpanan_pokok` int(11) DEFAULT NULL,
  `simpanan_wajib` int(11) DEFAULT NULL,
  `jenis_bunga` varchar(45) DEFAULT NULL,
  `bunga_simpanan` float DEFAULT NULL,
  `bunga_pinjaman` float DEFAULT NULL,
  `denda_pinjaman` float DEFAULT NULL,
  `keterangan` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `keanggotaan`
--

INSERT INTO `keanggotaan` (`id`, `jenis`, `simpanan_pokok`, `simpanan_wajib`, `jenis_bunga`, `bunga_simpanan`, `bunga_pinjaman`, `denda_pinjaman`, `keterangan`) VALUES
(2, 'Anggota', 500, 5000, 'tetap', 0.7, 2, 0.2, 'Setelah ada saldo simpanan pokok');

-- --------------------------------------------------------

--
-- Table structure for table `nasabah`
--

CREATE TABLE `nasabah` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) NOT NULL,
  `nama` varchar(40) NOT NULL,
  `departemen` varchar(40) DEFAULT '',
  `alamat` varchar(200) DEFAULT NULL,
  `hp` varchar(50) DEFAULT NULL,
  `keanggotaan_id` int(11) DEFAULT NULL,
  `tgl_masuk` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nasabah`
--

INSERT INTO `nasabah` (`id`, `kode`, `nama`, `departemen`, `alamat`, `hp`, `keanggotaan_id`, `tgl_masuk`) VALUES
(1, '12345', 'KHANIF FAOZI', '0', 'majalangu', '081119999', 2, '2017-02-01'),
(2, '12346', 'ELI ABDUL SYUKUR', '0', 'bungkus', '089111019', 2, '2017-02-15');

-- --------------------------------------------------------

--
-- Table structure for table `pinjaman`
--

CREATE TABLE `pinjaman` (
  `id` int(11) NOT NULL,
  `kode_nasabah` varchar(100) NOT NULL DEFAULT '',
  `jenis` enum('Uang','Barang') NOT NULL,
  `jumlah` int(20) NOT NULL,
  `bunga` float DEFAULT NULL,
  `total_bayar` int(20) DEFAULT NULL,
  `lama` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `preference`
--

CREATE TABLE `preference` (
  `attr` varchar(200) DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `preference`
--

INSERT INTO `preference` (`attr`, `value`) VALUES
('last_check_bunga', '2017-02-15'),
('kop_text', 'Koperasi Indonesia\nJakarta\nJl. Warga Raya No.30 RT 03/03 Pejaten Barat, Jakarta Selatan, Telp. 085259838599'),
('kop_koperasi', 'koperasi1.jpeg'),
('kop_logo', 'lambang-baru-koperasi-indonesia.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `simpanan`
--

CREATE TABLE `simpanan` (
  `id` int(11) NOT NULL,
  `kode_nasabah` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `jenis` enum('Pokok','Wajib','Sukarela','Bunga','Ambil') NOT NULL,
  `jumlah` float NOT NULL,
  `sld` float DEFAULT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `level` varchar(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `level`, `username`, `password`) VALUES
(5, 'Khanif Faozi Ganteng', 'admin', 'admin', '0192023a7bbd73250516f069df18b500');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_laporan`
-- (See below for the actual view)
--
CREATE TABLE `view_laporan` (
`id` int(11)
,`tabel` varchar(8)
,`kode_nasabah` varchar(100)
,`debet` varchar(11)
,`kredit` varchar(12)
,`tanggal` date
,`keterangan` varchar(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_laporan`
--
DROP TABLE IF EXISTS `view_laporan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_laporan`  AS  select `simpanan`.`id` AS `id`,'simpanan' AS `tabel`,`simpanan`.`kode_nasabah` AS `kode_nasabah`,'' AS `debet`,`simpanan`.`jumlah` AS `kredit`,`simpanan`.`tanggal` AS `tanggal`,`simpanan`.`jenis` AS `keterangan` from `simpanan` union select `pinjaman`.`id` AS `id`,'pinjaman' AS `tabel`,`pinjaman`.`kode_nasabah` AS `kode_nasabah`,`pinjaman`.`jumlah` AS `debet`,'' AS `kredit`,`pinjaman`.`tanggal` AS `tanggal`,`pinjaman`.`lama` AS `keterangan` from `pinjaman` union select `cicilan`.`id` AS `id`,'cicilan' AS `tabel`,`cicilan`.`kode_nasabah` AS `kode_nasabah`,'' AS `debet`,`cicilan`.`jumlah` AS `kredit`,`cicilan`.`tanggal` AS `tanggal`,`cicilan`.`cicilan_ke` AS `keterangan` from `cicilan` union select `denda`.`id` AS `id`,'denda' AS `tabel`,`denda`.`kode_nasabah` AS `kode_nasabah`,'' AS `debet`,`denda`.`jumlah` AS `kredit`,`denda`.`tanggal` AS `tanggal`,`denda`.`cicilan_ke` AS `keterangan` from `denda` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cicilan`
--
ALTER TABLE `cicilan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `denda`
--
ALTER TABLE `denda`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `keanggotaan`
--
ALTER TABLE `keanggotaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nasabah`
--
ALTER TABLE `nasabah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode` (`kode`);

--
-- Indexes for table `pinjaman`
--
ALTER TABLE `pinjaman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `simpanan`
--
ALTER TABLE `simpanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cicilan`
--
ALTER TABLE `cicilan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `denda`
--
ALTER TABLE `denda`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `keanggotaan`
--
ALTER TABLE `keanggotaan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `nasabah`
--
ALTER TABLE `nasabah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `pinjaman`
--
ALTER TABLE `pinjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `simpanan`
--
ALTER TABLE `simpanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
