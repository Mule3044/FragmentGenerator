CREATE OR REPLACE TYPE fragment_list IS TABLE OF VARCHAR2(100);

CREATE OR REPLACE TYPE fragment_map IS TABLE OF fragment_list INDEX BY VARCHAR2(100);

CREATE OR REPLACE PACKAGE FragmentGenerator AS
  FUNCTION fragment_generator(relations fragment_list, predicates fragment_list) RETURN fragment_map;
END FragmentGenerator;
/

CREATE OR REPLACE PACKAGE BODY FragmentGenerator AS
  FUNCTION fragment_generator(relations fragment_list, predicates fragment_list) RETURN fragment_map IS
    fragments fragment_map := fragment_map();
  BEGIN
    FOR i IN 1..relations.count LOOP
      fragments(relations(i)) := fragment_list();
      FOR j IN 1..predicates.count LOOP
        IF INSTR(predicates(j), relations(i)) > 0 THEN
          fragments(relations(i)).EXTEND;
          fragments(relations(i))(fragments(relations(i)).COUNT) := predicates(j);
        END IF;
      END LOOP;
    END LOOP;
    RETURN fragments;
  END fragment_generator;
END FragmentGenerator;
/
