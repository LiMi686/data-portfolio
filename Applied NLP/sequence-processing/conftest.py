import pytest
from collections import OrderedDict


tests = OrderedDict({"test_get_vocabulary": 16,
                     "test_format_examples": 16,
                     "test_create_model": 16,
                     "test_train_model": 16,
                     "test_make_predictions": 16,
                     "test_create_embedding_matrix": 10,
                     "test_create_model_with_embeddings": 10})
tests_grads = OrderedDict({"test_get_vocabulary_rels": 15,
                           "test_integrate_sentences_rels":20,
                           "test_format_examples_rels": 15,
                           "test_create_model_rels": 20,
                           "test_train_model_rels": 15,
                           "test_make_predictions_rels": 15})


def pytest_terminal_summary(terminalreporter, exitstatus, config):
    terminalreporter.section("Score")
    node_ids =  [rep.nodeid
                 for reps in terminalreporter.stats.values()
                 for rep in reps
                 if hasattr(rep, "nodeid") and rep.nodeid != ""]
    if node_ids[0].split("::")[0] == "test.py":
        tests_dict = tests
    elif node_ids[0].split("::")[0] == "test_grads.py":
        tests_dict = tests_grads
    else:
        Exception("Wrong test file!!")
    scores = OrderedDict({test_id: 0.0 for test_id in tests_dict})
    if 'passed' in terminalreporter.stats:
        for testreport in terminalreporter.stats['passed']:
            passed_test_id = testreport.nodeid.split("::")[-1]
            scores[passed_test_id] = tests_dict[passed_test_id]
    total_score = 0
    for test_id, score in scores.items():
        terminalreporter.write(f'{test_id}: {score}%\n')
        total_score += score
    terminalreporter.write(f'\nTotal Score: {total_score}%\n')
    terminalreporter.currentfspath = 1
    terminalreporter.ensure_newline()
