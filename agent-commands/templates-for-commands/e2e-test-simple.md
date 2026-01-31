# End-to-End Test Plan: [PRODUCT/PROJECT NAME]

**Version**: 1.0 | **Date**: [DATE] | **Status**: Active

**Note**: This is a lightweight E2E test plan for small to medium projects. For enterprise projects with complex requirements, use `e2e-test-comprehensive.md`.

---

## 1. Introduction

### 1.1 Purpose

This document defines the end-to-end (E2E) testing approach for [PRODUCT/PROJECT NAME]. E2E tests validate that the system works correctly as an integrated whole.

### 1.2 System Overview

**Product Description**: [Brief description of what the product does]

**Key Components**:
- Frontend: [e.g., React web app]
- Backend: [e.g., Node.js API]
- Database: [e.g., PostgreSQL]
- External Services: [e.g., Payment, Email]

**Reference**: See `docs/architecture.md` for detailed architecture.

---

## 2. Test Strategy

### 2.1 What We Test

E2E tests focus on:
- ✅ **Critical user journeys** that deliver core business value
- ✅ **System integration** between frontend, backend, and database
- ✅ **Key workflows** spanning multiple features
- ❌ **NOT** unit-level logic (covered by unit tests)
- ❌ **NOT** component internals (covered by integration tests)

### 2.2 Test Levels

| Level | Focus | When to Run |
|-------|-------|-------------|
| **Smoke Tests** | Critical happy paths (login, core action, logout) | Every commit |
| **Regression Tests** | All critical user journeys | Daily/Nightly |
| **Full Suite** | All scenarios including edge cases | Weekly/Pre-release |

### 2.3 Entry & Exit Criteria

**Run E2E tests when**:
- [ ] Unit tests pass ≥ 90%
- [ ] Code review completed
- [ ] Test environment is available

**E2E tests pass when**:
- [ ] Smoke tests pass 100%
- [ ] Regression tests pass ≥ 95%
- [ ] No critical (P0) failures

---

## 3. Critical User Journeys

<!--
  ACTION REQUIRED: Extract critical journeys from feature specifications
  Focus on 3-5 most important workflows
-->

### Journey 1: [Primary User Flow] - Priority: P0

**Why Critical**: [Business value - e.g., "Revenue-generating action"]

**Happy Path**:
1. User [action 1]
2. System [response 1]
3. User [action 2]
4. System [final state]

**Expected Outcome**: [What success looks like]

**Test Scenarios**:
- ✅ Happy path with valid data
- ✅ Error handling when [common error scenario]
- ✅ Data persists correctly in database

---

### Journey 2: [Secondary User Flow] - Priority: P0

[Same structure as Journey 1]

---

### Journey 3: [Tertiary User Flow] - Priority: P1

[Same structure as Journey 1]

---

## 4. Test Scenarios

### 4.1 Smoke Tests (P0 - Critical)

<!--
  ACTION REQUIRED: Define 5-10 critical scenarios that must always pass
-->

#### Scenario: User Can [Primary Action]

**Priority**: P0 | **Tags**: `smoke`, `critical`

**Steps**:
```gherkin
Given [precondition]
When [user action]
Then [expected result]
And [additional validation]
```

**Database Validation**:
```sql
-- Verify expected data state
SELECT [fields] FROM [table] WHERE [condition];
```

---

#### Scenario: User Authentication Works

**Priority**: P0 | **Tags**: `smoke`, `authentication`

**Steps**:
```gherkin
Given user is not logged in
When user logs in with valid credentials
Then user is redirected to dashboard
And session is created in database
```

---

#### Scenario: [Critical Action 3]

[Same structure]

---

### 4.2 Regression Tests (P1 - High Priority)

<!--
  ACTION REQUIRED: List important but non-critical scenarios
-->

| Scenario | Priority | Tags | Estimated Duration |
|----------|----------|------|-------------------|
| [Scenario Name] | P1 | [tags] | 2-3 min |
| [Scenario Name] | P1 | [tags] | 1-2 min |

---

### 4.3 Edge Cases & Negative Scenarios

<!--
  ACTION REQUIRED: Document how system handles errors and edge cases
-->

#### Scenario: System Handles [Error Condition]

**Priority**: P1 | **Tags**: `negative`, `validation`

**Steps**:
```gherkin
Given [setup]
When [invalid action]
Then [graceful error handling]
And [user sees helpful error message]
And [system state is not corrupted]
```

---

## 5. Test Data Management

### 5.1 Strategy

**Approach**: [Choose: Factory pattern / Database seeding / API-generated]

**Principles**:
- Each test uses independent data (no conflicts)
- Tests are repeatable (same data = same results)
- Data is cleaned up after tests
- Use synthetic data only (no real user data)

### 5.2 Test Data

**User Accounts**:
- Email: `test-{timestamp}@example.com` (unique per run)
- Password: `SecurePass123!`
- Role: user/admin as needed

**Test Data Cleanup**:
```typescript
// Example: Automatic cleanup
afterEach(async () => {
  await database.users.deleteMany({
    email: { contains: 'test-' }
  });
});
```

### 5.3 Sensitive Data Rules

- ❌ NEVER use real user data, emails, or payment cards
- ✅ ALWAYS use test payment cards (Stripe test mode: 4242 4242 4242 4242)
- ✅ ALWAYS use environment variables for credentials

---

## 6. Test Environment

### 6.1 Environments

| Environment | Purpose | URL |
|-------------|---------|-----|
| **Local** | Development | localhost:3000 |
| **CI** | Automated tests | [ephemeral] |
| **Staging** | Pre-production | [staging URL] |

### 6.2 Setup

**Local Development**:
```bash
# Start services
docker-compose -f docker-compose.test.yml up -d

# Run migrations
npm run db:migrate

# Seed test data
npm run db:seed:test

# Start app
npm run start:test
```

**CI/CD**:
```yaml
# GitHub Actions example
- name: Setup test environment
  run: |
    docker-compose up -d postgres redis
    npm run db:migrate
```

### 6.3 External Services

**Mock these services**:
- Payment gateways (use test mode)
- Email services (use Mailhog/Mailtrap)
- SMS services (use mock provider)

---

## 7. Test Framework & Tools

### 7.1 Selected Tools

<!--
  ACTION REQUIRED: Choose framework based on your tech stack
-->

**Testing Framework**: [e.g., Playwright / Cypress / Selenium]

**Why chosen**: [Brief justification - e.g., "Cross-browser support, auto-wait"]

**Tool Stack**:
- UI Testing: [Playwright]
- API Testing: [Supertest]
- Test Runner: [Jest/Vitest]
- Data Generation: [Faker.js]
- Reporting: [HTML Report + JSON]

### 7.2 Configuration

**Example: Playwright Config**
```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './tests/e2e',
  workers: 4,
  retries: process.env.CI ? 2 : 0,
  use: {
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },
  projects: [
    { name: 'chromium', use: devices['Desktop Chrome'] },
    { name: 'mobile', use: devices['iPhone 13'] },
  ],
});
```

---

## 8. Test Organization

### 8.1 Directory Structure

```
tests/
├── e2e/
│   ├── pages/              # Page Object Models
│   │   ├── LoginPage.ts
│   │   └── DashboardPage.ts
│   ├── fixtures/           # Test data
│   │   └── users.json
│   ├── helpers/            # Utilities
│   │   ├── auth.ts
│   │   └── database.ts
│   └── scenarios/          # Test scenarios
│       ├── smoke/
│       │   └── critical-paths.spec.ts
│       └── regression/
│           └── user-management.spec.ts
```

### 8.2 Page Object Pattern

```typescript
// Example: Page Object
export class LoginPage {
  constructor(private page: Page) {}
  
  async navigate() {
    await this.page.goto('/login');
  }
  
  async login(email: string, password: string) {
    await this.page.fill('#email', email);
    await this.page.fill('#password', password);
    await this.page.click('button[type="submit"]');
  }
  
  async expectSuccess() {
    await expect(this.page).toHaveURL('/dashboard');
  }
}
```

### 8.3 Test Structure (AAA Pattern)

```typescript
test('User can login', async ({ page }) => {
  // ARRANGE - Setup
  const user = await UserFactory.create();
  const loginPage = new LoginPage(page);
  await loginPage.navigate();
  
  // ACT - Perform action
  await loginPage.login(user.email, user.password);
  
  // ASSERT - Verify
  await loginPage.expectSuccess();
  
  // Verify database
  const dbUser = await db.users.findByEmail(user.email);
  expect(dbUser.lastLoginAt).toBeDefined();
});
```

---

## 9. Execution Plan

### 9.1 Test Suites

| Suite | Scenarios | Duration | When to Run |
|-------|-----------|----------|-------------|
| **Smoke** | P0 critical paths | ~5-10 min | Every commit |
| **Regression** | P0 + P1 | ~30-60 min | Daily (nightly) |
| **Full** | All scenarios | ~1-2 hours | Weekly/Pre-release |

### 9.2 Running Tests

```bash
# Run smoke tests
npm run test:e2e:smoke

# Run regression suite
npm run test:e2e:regression

# Run all tests
npm run test:e2e

# Run specific test file
npm run test:e2e -- tests/e2e/scenarios/smoke/critical-paths.spec.ts

# Run with specific browser
npm run test:e2e -- --project=firefox
```

### 9.3 CI/CD Integration

**GitHub Actions Example**:
```yaml
name: E2E Tests

on:
  push:
    branches: [main]
  pull_request:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM

jobs:
  e2e:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: docker-compose up -d
      - run: npm run test:e2e:smoke
      - uses: actions/upload-artifact@v3
        if: always()
        with:
          name: test-results
          path: test-results/
```

---

## 10. Reporting & Metrics

### 10.1 Test Reports

**Report Types**:
- HTML Report: Human-readable results with screenshots
- JSON Report: Machine-readable data
- JUnit XML: CI/CD integration

**Report Location**: `test-results/` directory

### 10.2 Key Metrics

| Metric | Target |
|--------|--------|
| **Pass Rate** | ≥ 95% |
| **Execution Time** (full suite) | ≤ 2 hours |
| **Flaky Rate** | ≤ 2% |
| **Coverage** | ≥ 90% of critical journeys |

### 10.3 Failure Notifications

**Notify on**:
- Smoke test failures (immediate)
- Regression failures (summary after run)

**Channels**:
- Slack: [#test-failures]
- Email: [QA team]
- GitHub: PR comments

---

## 11. Maintenance

### 11.1 Flaky Test Management

**Flaky test** = Test that passes/fails inconsistently

**How to handle**:
1. Track flaky tests (tag with `@flaky`)
2. Investigate root cause (timing issues, race conditions)
3. Fix or quarantine
4. Document in code comments

```typescript
// Known flaky - investigating (TICKET-123)
test('Intermittent failure', async ({ page }) => {
  // Add extra wait time temporarily
  await page.waitForTimeout(2000);
  // ... rest of test
});
```

### 11.2 Maintenance Schedule

| Task | Frequency |
|------|-----------|
| Review flaky tests | Weekly |
| Update test data | Monthly |
| Review coverage | Monthly |
| Refactor tests | As needed |

---

## 12. Appendices

### 12.1 Quick Reference

**Test Priorities**:
- **P0 (Critical)**: Must pass for release - core business functionality
- **P1 (High)**: Important features - should pass
- **P2 (Medium)**: Secondary features - nice to have

**Common Commands**:
```bash
# Quick smoke test
npm run test:e2e:smoke

# Debug mode (headed browser)
npm run test:e2e -- --headed --debug

# Update snapshots
npm run test:e2e -- --update-snapshots
```

### 12.2 Troubleshooting

**Tests timing out?**
- Increase timeout in config
- Check for slow network requests
- Verify test data generation isn't blocking

**Tests failing in CI but passing locally?**
- Check environment differences
- Verify test data setup
- Check for race conditions

**Flaky tests?**
- Add explicit waits instead of arbitrary timeouts
- Use proper assertions that auto-wait
- Check for test data conflicts

### 12.3 References

- Architecture: `docs/architecture.md`
- Standards: `docs/standards.md`
- Framework Docs: [Link to Playwright/Cypress docs]

### 12.4 Contact

| Role | Contact |
|------|---------|
| **QA Lead** | [Name/Email] |
| **On-Call** | [Slack channel] |

---

**END OF E2E TEST PLAN**

---

**Note**: This simplified template is suitable for projects with:
- Small to medium team size (1-5 QA engineers)
- Standard web/mobile applications
- Moderate complexity (3-10 critical user journeys)

For enterprise projects with complex requirements, multiple environments, extensive integration needs, or large teams, use `e2e-test-comprehensive.md` instead.
