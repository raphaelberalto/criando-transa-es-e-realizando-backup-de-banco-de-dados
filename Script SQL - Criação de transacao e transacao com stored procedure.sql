use ecommerce;

SET @@autocommit = 0;

SELECT @@autocommit;

-- Primeira transação

START TRANSACTION;

INSERT INTO product (idProduct, Pname, classification_kids, category, avaliação, size)
VALUES (8, 'Controle Dualsense', 0, 1, 5, NULL);

COMMIT;

-- Segunda transação com procedure

DELIMITER $$

CREATE PROCEDURE AtualizarProdutoSavepoint (
    IN p_idProduct INT,
    IN p_nome VARCHAR(50),
    IN p_categoria ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis')
)
BEGIN

    DECLARE erro INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET erro = 1;

    START TRANSACTION;

    -- Atualização principal
    UPDATE product
    SET Pname = p_nome
    WHERE idProduct = p_idProduct;

    IF ROW_COUNT() = 0 OR erro = 1 THEN
        ROLLBACK;
    ELSE
        SAVEPOINT sp1;

        -- Atualização secundária (opcional)
        UPDATE product
        SET category = p_categoria
        WHERE idProduct = p_idProduct;

        IF erro = 1 THEN
            ROLLBACK TO sp1;
            COMMIT;
        ELSE
            COMMIT;
        END IF;
    END IF;

END$$

DELIMITER ;