def test_home_page_loads(db, tp):
    tp.get_check_200("/")
