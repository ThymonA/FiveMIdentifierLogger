CREATE TABLE `user_identifiers` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NULL,
    `license` VARCHAR(255) NULL,
    `xbl` VARCHAR(255) NULL,
    `live` VARCHAR(255) NULL,
    `discord` VARCHAR(255) NULL,
    `fivem` VARCHAR(255) NULL,
    `ip` VARCHAR(255) NULL,
    `date` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
);