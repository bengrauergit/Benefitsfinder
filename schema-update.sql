-- ============================================================
-- BenefitsFinder Australia — Schema Update v2
-- Run this in the Supabase SQL Editor AFTER the original schema.sql
-- This adds the benefits table for dynamic benefit management
-- ============================================================

-- ============================================================
-- TABLE: benefits
-- All benefit data lives here — updated weekly by the agent
-- ============================================================
CREATE TABLE IF NOT EXISTS benefits (
  id                    TEXT PRIMARY KEY,          -- e.g. 'age-pension', 'family-tax-a'
  name                  TEXT NOT NULL,
  category              TEXT NOT NULL DEFAULT 'government',
                        -- values: 'government', 'energy', 'healthcare', 'product'
  estimated_value       INTEGER NOT NULL DEFAULT 0, -- annual $ value
  frequency             TEXT DEFAULT 'per year',
  description           TEXT,
  official_link         TEXT,
  why_eligible_template TEXT,                       -- e.g. "You are aged 67+..."
  eligibility_rules     JSONB NOT NULL DEFAULT '{}',
  -- eligibility_rules structure:
  -- {
  --   "age_groups": ["67plus"] or null (null = any age),
  --   "employment_types": ["unemployed","disabled"] or null,
  --   "max_income_bracket": "over150k" or null (null = no limit),
  --   "min_income_bracket": null,
  --   "requires_children": false,
  --   "requires_renting": false,
  --   "requires_disability": false,
  --   "requires_veteran": false,
  --   "requires_first_home": false,
  --   "requires_newborn": false,
  --   "requires_carer": false,
  --   "requires_solar": false,
  --   "requires_concession_card": false,
  --   "requires_studying": false,
  --   "states": ["NSW","VIC"] or null (null = all states),
  --   "probability": 85
  -- }
  criteria              TEXT[]   DEFAULT '{}',      -- bullet point eligibility criteria
  documents             TEXT[]   DEFAULT '{}',      -- required documents
  steps                 TEXT[]   DEFAULT '{}',      -- step-by-step claim instructions
  source_url            TEXT,                       -- where the agent found this benefit
  is_active             BOOLEAN  DEFAULT true,      -- false = soft-delete / no longer available
  last_verified         TIMESTAMPTZ DEFAULT NOW(),  -- last time agent confirmed still active
  agent_notes           TEXT,                       -- agent's notes on changes found
  created_at            TIMESTAMPTZ DEFAULT NOW(),
  updated_at            TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- ROW LEVEL SECURITY for benefits table
-- Public can READ (so the website can show benefits without login)
-- Only the service role can WRITE (the agent uses service role key)
-- ============================================================
ALTER TABLE benefits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read active benefits"
  ON benefits FOR SELECT
  USING (is_active = true);

-- Note: Writes use the service_role key which bypasses RLS automatically
-- No insert/update policy needed for anon users

-- ============================================================
-- AUTO-UPDATE timestamp on benefits
-- ============================================================
CREATE TRIGGER benefits_updated_at
  BEFORE UPDATE ON benefits
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- TABLE: agent_runs
-- Log of every time the discovery agent runs
-- ============================================================
CREATE TABLE IF NOT EXISTS agent_runs (
  id             UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  run_at         TIMESTAMPTZ DEFAULT NOW(),
  benefits_added INTEGER DEFAULT 0,
  benefits_updated INTEGER DEFAULT 0,
  benefits_deactivated INTEGER DEFAULT 0,
  sources_searched TEXT[],
  summary        TEXT,
  errors         TEXT
);

-- agent_runs is admin-only (service role only)
ALTER TABLE agent_runs ENABLE ROW LEVEL SECURITY;
-- No public policies — only service role can access

-- ============================================================
-- DONE — Now run seed-benefits.sql to populate initial data
-- ============================================================
