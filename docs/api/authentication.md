# Authentication

The API uses token-based authentication. To access protected endpoints, follow these steps:

1. **Login**: Send a POST request to `/api/auth/login` with your credentials.
2. **Receive Token**: On successful login, a JWT token will be returned.
3. **Use Token**: Include the token in the Authorization header for subsequent requests.

## Example Login Endpoint (Node.js)

```javascript
1 const jwt = require('jsonwebtoken');
2 
3 app.post('/api/auth/login', (req, res) => {
4     const { username, password } = req.body;
5     // Authenticate user
6     // ...
7     const token = jwt.sign({ userId: user.id }, process.env.SECRET_KEY, { expiresIn: '1h' });
8     res.json({ token });
9 });
```
