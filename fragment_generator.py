class HMFG:
    def __init__(self, relations, predicates):
        self.relations = relations
        self.predicates = predicates

    def fragment_generator(self):
        fragments = {}
        for relation in self.relations:
            fragments[relation] = []
            for predicate in self.predicates:
                if relation in predicate:
                    fragments[relation].append(predicate)
        return fragments

relations = ['R', 'S']
predicates = ['R.A = 1', 'S.B = 2', 'R.C = 3', 'S.D = 4']
result = HMFG(relations, predicates)
fragments_result = result.fragment_generator()
print(fragments_result)