# E2E Test Templates Guide

This document explains the two E2E test templates available in Quynhluu and helps you choose the right one for your project.

## Template Options

### 1. Simple Template (`e2e-test-simple.md`)

**Best for:**
- Small to medium projects
- 3-10 critical user journeys
- Team size: 1-5 QA engineers
- Standard web or mobile applications
- Moderate complexity
- Projects with straightforward integration patterns

**Characteristics:**
- ~200 lines
- Focuses on essentials
- Streamlined structure
- Quick to fill out
- Suitable for startups and MVP projects

**Sections included:**
- Introduction & System Overview
- Test Strategy (simplified)
- Critical User Journeys (3-5 key flows)
- Test Scenarios (P0 smoke + P1 regression)
- Test Data Management (basic)
- Test Environment (local, CI, staging)
- Test Framework & Tools
- Test Organization (directory structure, patterns)
- Execution Plan (smoke, regression, full)
- Reporting & Metrics (key metrics)
- Maintenance (flaky test management)
- Quick Reference & Troubleshooting

### 2. Comprehensive Template (`e2e-test-comprehensive.md`)

**Best for:**
- Enterprise projects
- Complex requirements
- Large teams (6+ QA engineers)
- Multiple environments
- Extensive integrations
- Strict compliance needs (PCI, HIPAA, SOC2)
- Mission-critical systems

**Characteristics:**
- ~1200 lines
- Enterprise-grade detail
- Complete test strategy documentation
- Suitable for regulated industries
- Comprehensive stakeholder analysis

**Additional sections (compared to simple):**
- Detailed stakeholder analysis
- Comprehensive test pyramid documentation
- Extensive scenario catalog
- Advanced test data strategies
- Multiple environment configurations
- Service mocking strategies
- Infrastructure requirements
- Visual & accessibility testing
- Performance testing integration
- Security testing considerations
- Advanced reporting & dashboards
- Test maintenance schedules
- Complete appendices with references

## How to Choose

Use this decision matrix:

| Factor | Simple Template | Comprehensive Template |
|--------|----------------|----------------------|
| **Team Size** | 1-5 QA engineers | 6+ QA engineers |
| **User Journeys** | 3-10 critical paths | 10+ critical paths |
| **Integrations** | 1-5 external services | 6+ external services |
| **Environments** | 2-3 (local, CI, staging) | 4+ (local, CI, QA, staging, pre-prod) |
| **Compliance** | None or minimal | PCI, HIPAA, SOC2, etc. |
| **Timeline** | MVP or rapid development | Long-term, phased rollout |
| **Budget** | Limited QA budget | Dedicated QA budget |
| **Risk** | Low to medium | High (financial, health, security) |

## Usage

The `/quynhluu.design-e2e-test` command automatically selects the appropriate template based on project context. By default, it uses the **simple template** (suitable for most projects, with easy upgrade path to comprehensive).

### Override Template Selection

You can explicitly request a specific template:

```bash
# Request comprehensive template (default is simple)
/quynhluu.design-e2e-test use comprehensive template

# Explicitly request simple template (default, but can be explicit)
/quynhluu.design-e2e-test use simple template
```

### Script-Level Override

For automation, you can pass the `--comprehensive` flag to the setup script:

```bash
# Bash
scripts/bash/setup-design-e2e-test.sh --comprehensive

# PowerShell
scripts/powershell/setup-design-e2e-test.ps1 -Comprehensive
```

## When to Switch Templates

### Start with Simple, Upgrade Later

If you're unsure, start with the **simple template**. You can always:
1. Create comprehensive test plan when needed
2. Copy relevant content from simple template
3. Expand with enterprise-grade details

**Indicators to upgrade:**
- Team grows beyond 5 QA engineers
- Adding complex compliance requirements
- Multiple production environments needed
- Extensive stakeholder reporting required
- Test maintenance becomes challenging

### Start with Comprehensive, Simplify Later

If you started with **comprehensive template** but find it overwhelming:
1. Use it as reference documentation
2. Create simplified working document
3. Keep comprehensive version for audits/compliance

## Template Maintenance

Both templates are maintained in:
```
.quynhluu/templates/templates-for-commands/
├── e2e-test-simple.md
└── e2e-test-comprehensive.md
```

When Quynhluu is updated, both templates are refreshed with latest best practices.

## Examples

### Simple Template Example Project
- **Project**: E-commerce MVP
- **Team**: 2 QA engineers
- **Journeys**: Browse, Search, Add to Cart, Checkout, Order Status
- **Stack**: React frontend, Node.js backend, PostgreSQL
- **Timeline**: 3-month MVP

### Comprehensive Template Example Project
- **Project**: Healthcare platform
- **Team**: 12 QA engineers
- **Journeys**: 15+ user journeys across patient, provider, admin portals
- **Stack**: Microservices, React Native mobile, multiple backends
- **Compliance**: HIPAA, SOC2
- **Timeline**: 18-month phased rollout

## Migration Path

### From Simple to Comprehensive

1. Run `/quynhluu.design-e2e-test use comprehensive template`
2. Copy sections from existing simple plan
3. Expand each section with additional detail
4. Add new sections (stakeholder analysis, compliance, etc.)
5. Update agent context

### From Comprehensive to Simple

1. Create new simple template
2. Extract core scenarios (P0 only)
3. Remove enterprise-specific sections
4. Simplify environment documentation
5. Archive comprehensive version for reference

## Best Practices

1. **Start with simple** for most projects; upgrade to comprehensive when needed
2. **Review quarterly** to determine if template still fits
3. **Mix and match** sections as needed (templates are guidelines)
4. **Document deviations** if you customize templates
5. **Keep both** if you have multiple products with different needs

## Questions?

If unsure which template to use, ask yourself:
- "Could a test failure cause financial loss or harm?"
  - **Yes**: Comprehensive
  - **No**: Simple (default)
- "Do we need extensive audit trails for compliance?"
  - **Yes**: Comprehensive
  - **No**: Simple (default)
- "Is this a short-term MVP or long-term product?"
  - **MVP**: Simple (default)
  - **Long-term**: Start simple, upgrade when complexity warrants

**When in doubt, start with simple.** You can always upgrade to comprehensive later when your project grows or requirements become more complex.

## Further Reading

- [E2E Testing Best Practices](https://docs.github.com/en/actions/automating-builds-and-tests)
- [Test Pyramid Concept](https://martinfowler.com/articles/practical-test-pyramid.html)
- [Playwright Documentation](https://playwright.dev/)
- [Cypress Best Practices](https://docs.cypress.io/guides/references/best-practices)
