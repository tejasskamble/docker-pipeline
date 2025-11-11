const express = require('express');
const app = express();
const PORT = 3000;

// Read build info from environment variables
const buildId = process.env.BUILD_ID || 'Not Set';
const gitCommit = process.env.GIT_COMMIT || 'Not Set';

app.get('/', (req, res) => {
  res.send(`
    <h1>Hello from the Advanced Docker Build!</h1>
    <p>This app was built by Jenkins.</p>
    <ul>
      <li><b>Build ID:</b> ${buildId}</li>
      <li><b>Git Commit:</b> ${gitCommit}</li>
    </ul>
  `);
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
