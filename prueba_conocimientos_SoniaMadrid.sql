
 create table teams (
      team_id integer not null primary key,
      team_name varchar(30) not null,
      unique(team_id)
  );

  create table matches (
      match_id integer not null primary key,
      host_team integer not null,
      guest_team integer not null,
      host_goals integer not null,
      guest_goals integer not null,
      unique(match_id)
  );
  --REGISTO DEL EQUIPO
  INSERT INTO teams VALUES (10, 'Give')
  INSERT INTO teams VALUES (20, 'Never')
  INSERT INTO teams VALUES (30, 'You')
  INSERT INTO teams VALUES (40, 'Up')
  INSERT INTO teams VALUES (50, 'Gonna')

 SELECT *FROM teams

 --REGISTO DEL JUEGO
 INSERT INTO matches VALUES (1,30,20,1,0 )
 INSERT INTO matches VALUES (2,10,20,1,2 )
 INSERT INTO matches VALUES (3,20,50,2,2 )
 INSERT INTO matches VALUES (4,10,30,1,0 )
 INSERT INTO matches VALUES (5,30,50,0,1 )

 SELECT *FROM matches

/*Si un equipo gana un partido 
 ( marca estrictamente más goles que el otro equipo ), recibe tres puntos.
Si un equipo dibuja un partido
( marca exactamente el mismo número de goles que el oponente ), recibe un punto.
Si un equipo pierde un partido
( marca menos goles que el oponente ), no recibe puntos.
 */

 SELECT team_id, team_name, 
      COALESCE(SUM(CASE WHEN team_id = host_team THEN (
                    CASE WHEN host_goals > guest_goals THEN 3
                    WHEN host_goals = guest_goals THEN 1
                    WHEN host_goals < guest_goals THEN 0
                    END ) 
                   WHEN team_id = guest_team THEN (
                   CASE WHEN guest_goals > host_goals THEN 3
                   WHEN guest_goals = host_goals THEN 1
                   WHEN guest_goals < host_goals THEN 0
                   END  )
                   END), 0) AS num_points

    FROM teams LEFT JOIN matches
    ON teams.team_id = matches.host_team
    OR teams.team_id = matches.guest_team
   GROUP BY team_id, team_name
   ORDER BY num_points DESC, team_id

 
    

