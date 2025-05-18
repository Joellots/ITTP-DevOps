import unittest
from app import app

class TestAdditionApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def test_home(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to Joel\'s Root App!', response.data)

    def test_root_number(self):
        response = self.app.get('/root?num=64')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'"result":8.0', response.data)

    def test_invalid_input(self):
        response = self.app.get('/root?num=abc')
        self.assertEqual(response.status_code, 400)
        self.assertIn(b'Invalid input', response.data)

if __name__ == '__main__':
    unittest.main()





