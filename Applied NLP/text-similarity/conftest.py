from collections import OrderedDict


tests = OrderedDict({"test_process_sentences": 20,
                     "test_load_model": 20,
                     "test_cosine_similarity": 20,
                     "test_scale_similarities": 20,
                     "test_word_movers_similarity": 20})


def pytest_terminal_summary(terminalreporter, exitstatus, config):
    terminalreporter.section("Score")
    scores = OrderedDict({test_id: 0.0 for test_id in tests})
    if 'passed' in terminalreporter.stats:
        for testreport in terminalreporter.stats['passed']:
            passed_test_id = testreport.nodeid.split("::")[-1]
            scores[passed_test_id] = tests[passed_test_id]
    total_score = 0
    for test_id, score in scores.items():
        terminalreporter.write(f'{test_id}: {score}%\n')
        total_score += score
    terminalreporter.write(f'\nTotal Score: {total_score}%\n')
    terminalreporter.currentfspath = 1
    terminalreporter.ensure_newline()
