CREATE TABLE heroes(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    power_values INTEGER NOT NULL,
    power_type VARCHAR(255) NOT NULL,
    hp INTEGER NOT NULL,
    attack INTEGER NOT NULL
);

INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Superman', 50, 'kriptoniano', 3000, 280);
INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Batman', 35, 'Rico', 2200, 180);
INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Spider-man', 40, 'homem aranha', 2500, 200);
INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Wonder Woman', 45, 'guerreira', 2800, 270);
INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Iron Man', 48, 'inteligente', 2800, 250);
INSERT INTO heroes (name, power_values, power_type, hp, attack) VALUES ('Captain America', 42, 'forte', 2600, 220);

CREATE TABLE batalhas (
    id INTEGER PRIMARY KEY,
    heroes_p INTEGER NOT NULL,
   heroes_s INTEGER NOT NULL,
    FOREIGN KEY (heroes_p) REFERENCES heroes(id),
    FOREIGN KEY (heroes_s) REFERENCES heroes(id)
);

INSERT INTO batalhas (id,heroes_p, heroes_s) VALUES (1,1, 2);

CREATE OR REPLACE FUNCTION obter_vencedor_batalha(batalha_id INTEGER)
RETURNS VARCHAR(255) AS
$$
DECLARE
    winner_name VARCHAR(255);
BEGIN
    
    SELECT CASE
               WHEN (h1.attack + h1.power_values) > (h2.attack + h2.power_values) THEN h1.name
               WHEN (h1.attack + h1.power_values) < (h2.attack + h2.power_values) THEN h2.name
               ELSE 'Empate'
           END INTO winner_name
    FROM batalhas AS b
    INNER JOIN heroes AS h1 ON b.heroes_p = h1.id
    INNER JOIN heroes AS h2 ON b.heroes_s = h2.id
    WHERE b.id = batalha_id;

    RETURN winner_name;
END;
$$
LANGUAGE plpgsql;

SELECT FROM obter_vencedor_batalha(1);