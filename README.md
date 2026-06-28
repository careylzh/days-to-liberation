Back in undergraduate studies, the user wanted to make a personal countdown timer for the end of semester and deploy it on AWS. With recent advances in AI, we can use github pages to host it.

# Days to Liberation

A small, responsive React countdown page for one important date. The current example counts down to **Copa De Singapura - Grand Finale** on **14 November 2026**.

The app calculates the number of calendar days from the visitor's local date. Before the event it shows “days to go,” on the date it shows “happening today,” and afterwards it shows “days since.” It is a static site: there is no server, database, sign-in, or AWS setup.

## Run it locally

You need:

- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/) and npm (npm is included with Node.js)
- A [GitHub](https://github.com/) account if you want to publish the site

Clone the repository and install its exact dependency versions:

```bash
git clone https://github.com/careylzh/days-to-liberation.git
cd days-to-liberation
npm ci
npm start
```

Open [http://localhost:3000](http://localhost:3000). The development server reloads the page after saved code changes.

## Make the countdown yours

Open `src/App.js` and edit the first item in the `events` array:

```js
const events = [
  {
    id: 'graduation-day',
    name: 'Graduation Day',
    date: '2027-06-30',
  },
];
```

Use a unique short `id` and write the date as `YYYY-MM-DD`. Although the data is stored in an array, the current interface displays only the first event.

To change the appearance, edit `src/App.css`. The background currently loads a remote Unsplash image, so visitors need an internet connection for that image to appear.

Check the production build before publishing:

```bash
npm test -- --watchAll=false
npm run build
```

The optimized static site is created in `build/`.

## Deploy your own copy to GitHub Pages

This project uses the `gh-pages` package. `npm run deploy` builds the app, creates or updates a `gh-pages` branch, and pushes the contents of `build/` to that branch.

### 1. Create your copy on GitHub

On the repository's GitHub page, click **Fork**, choose your account, and keep the repository name `days-to-liberation`. Then clone your fork, replacing `YOUR-USERNAME` below:

```bash
git clone https://github.com/YOUR-USERNAME/days-to-liberation.git
cd days-to-liberation
npm ci
```

If you rename the repository, use the new name everywhere `days-to-liberation` appears in the following steps.

### 2. Set the public site address

In `package.json`, replace the existing `homepage` value with your own username and repository name:

```json
"homepage": "https://YOUR-USERNAME.github.io/days-to-liberation"
```

This value is important: Create React App uses it to generate the correct JavaScript and CSS paths for a project site.

### 3. Commit and push your customization

```bash
git add src/App.js src/App.css package.json
git commit -m "Customize my countdown"
git push origin main
```

Omit files you did not change from the `git add` command. If your fork uses a different default branch, replace `main` with that branch name.

### 4. Publish the site

```bash
npm run deploy
```

Git may ask you to authenticate with GitHub. When the command finishes, it will have pushed a generated `gh-pages` branch to your fork.

### 5. Enable GitHub Pages

In your fork on GitHub:

1. Open **Settings** → **Pages**.
2. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
3. Select the `gh-pages` branch and the `/(root)` folder, then click **Save**.
4. Wait for GitHub's Pages deployment to finish, then visit `https://YOUR-USERNAME.github.io/days-to-liberation/`.

GitHub documents this setup in [Configuring a publishing source for your GitHub Pages site](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site). The first publication may take a few minutes.

## Publish later changes

After editing the countdown, verify and deploy it again:

```bash
npm test -- --watchAll=false
npm run deploy
```

Commit and push the source changes to your normal branch as well. The `gh-pages` branch contains generated website files; `main` (or your default branch) should remain the source of truth.

## Available commands

- `npm start` — run the local development server
- `npm test` — run tests in interactive watch mode
- `npm run build` — create an optimized production build
- `npm run deploy` — build and publish `build/` to the `gh-pages` branch
- `npm run eject` — expose Create React App's internal configuration; this is irreversible and is not needed for normal use

## Current limitations

- Only the first hard-coded event in `src/App.js` is displayed.
- Visitors cannot add or save dates in the browser.
- The countdown updates when the page renders; it does not automatically refresh at local midnight.
