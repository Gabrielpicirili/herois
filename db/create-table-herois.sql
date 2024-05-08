CREATE TABLE heros(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    poder_values INTERGER NOT NULL,
    poder_type VARCHAR(255) NOT NULL,
    hp INTERGER NOT NULL,
    attack INTERGER NOT NULL
);

INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Superman'   50, 'kriptoniano',  3000,  280 );
INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Batman'   35, 'Rico',  2200,  180 );
INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Spider-man'   40, 'homem aranha',  2500,  200 );
INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Wonder Woman '   45, 'guerraira',  2800,  270 );
INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Iron Man'   48, 'inteligente',  2800,  250 );
INSERT INTO heros (name, poder_values, poder_type, hp, attack) VALUES ('Captain America '   42, 'forte',  2600,  220 );

CREATE TABLE batalhas (
    id INTEGER PRIMARY KEY,
    heros_p INTEGER NOT NULL,
   heros_s INTEGER NOT NULL,
    FOREIGN KEY (heros_p) REFERENCES heros(id),
    FOREIGN KEY (heros_s) REFERENCES heros(id)
);

INSERT INTO batalhas (id,heros_p, heros_s) VALUES (1,1, 2);

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
    INNER JOIN heros AS h1 ON b.heros_p = h1.id
    INNER JOIN heros AS h2 ON b.heros_s = h2.id
    WHERE b.id = batalha_id;

    RETURN winner_name;
END;
$$
LANGUAGE plpgsql;

SELECT FROM obter_vencedor_batalha(1);