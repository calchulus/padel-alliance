# Deploy Padel Alliance on GitHub Pages

This project is a static React + Vite demo. GitHub Pages can host the frontend for free on eligible repositories. It cannot host the backend services required for live authentication, shared game invitations, real-time booking inventory, or payments.

## One-time setup

1. Create a new GitHub repository (for example `padel-alliance`).
2. Extract the ZIP, then upload **the contents of the `padel-alliance` folder** to the root of the repository. Include `.github/workflows/deploy.yml` (hidden folders may not show in some file browsers). Alternatively, use Git to push the whole project.
3. Ensure the default branch is named `main`. If using a different branch, edit `.github/workflows/deploy.yml`.
4. On GitHub, go to **Settings → Pages → Build and deployment → Source** and select **GitHub Actions**.
5. Open **Actions**, run **Deploy Padel Alliance to GitHub Pages** (or push a commit to `main`).
6. Wait for the workflow to finish. Visit `https://YOUR-USERNAME.github.io/padel-alliance/` (replace both parts with your actual username and repository name).

The workflow automatically sets the correct Vite base path for a normal project repository or a `USERNAME.github.io` repository. Custom domains generally need base `/`; if your site uses a custom domain with a project repository, change the `Set site base path` step to `echo "VITE_BASE_PATH=/" >> "$GITHUB_ENV"` and configure the custom domain in Pages settings.

## Local preview

```sh
npm install
npm run dev
```

## Local production build

```sh
npm run build
npm run preview
```

## Important limitations

- Browser-local demo data is stored in localStorage, independently on each device/browser. It is not synchronized or backed up.
- Email and social sign-in, WhatsApp/WeChat provider integrations, real payments, notifications, and court synchronization are NOT implemented as live services.
- Invitation links can reference only games already saved in the same browser.
- The app uses view state rather than pathname-based routing, so it works with Pages without an SPA 404 fallback. Invitation query parameters are preserved.
- Do not put payment secrets or server credentials in Vite environment variables: client bundles are public.
