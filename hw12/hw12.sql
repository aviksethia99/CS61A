CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name, b.size
  FROM dogs AS a, sizes AS b
  WHERE a.height>b.min AND a.height<=b.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT a.name
  FROM dogs AS a, dogs AS c, parents AS b
  WHERE b.child=a.name AND c.name=b.parent
  ORDER BY c.height DESC;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT "REPLACE THIS LINE WITH YOUR SOLUTION";

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.name || " and " || b.name || " are " || a.size || " siblings"
  FROM size_of_dogs AS a, size_of_dogs AS b, parents AS c, parents AS d
  WHERE a.size=b.size AND a.name<b.name AND c.child=a.name AND d.child=b.name AND c.parent=d.parent
  ORDER BY a.name DESC;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper SELECT name, height, height FROM dogs;

INSERT INTO stacks_helper
  SELECT s.dogs || ", " || d.name, s.stack_height + d.height, d.height
  FROM stacks_helper AS s, dogs AS d
  WHERE d.height > s.last_height;


  INSERT INTO stacks_helper
    SELECT s.dogs || ", " || d.name, s.stack_height + d.height, d.height
    FROM stacks_helper AS s, dogs AS d
    WHERE d.height > s.last_height;


    INSERT INTO stacks_helper
      SELECT s.dogs || ", " || d.name, s.stack_height + d.height, d.height
      FROM stacks_helper AS s, dogs AS d
      WHERE d.height > s.last_height;

CREATE TABLE stacks AS
  SELECT dogs, stack_height FROM stacks_helper
  WHERE stack_height > 170
  ORDER BY stack_height;

-- CREATE TABLE stacks AS
--  SELECT a.name || ", " || b.name || ", " || c.name || ", " || d.name, (a.height + b.height + c.height + d.height)
--  FROM dogs AS a, dogs AS b, dogs AS c, dogs AS d
--  WHERE a.height<b.height AND b.height<c.height AND c.height<d.height AND a.height+b.height+c.height+d.height>170
--  ORDER BY (a.height + b.height + c.height + d.height);
