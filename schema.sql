-- ============================================================
-- BenefitsFinder Australia - Supabase Database Schema
-- Run this in the Supabase SQL Editor after creating your project
-- ============================================================

-- Enable UUID extension (usually already enabled)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- TABLE: profiles
-- Stores each user's eligibility questionnaire answers
-- ============================================================
CREATE TABLE IF NOT EXISTS profiles (
  id           UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id      UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE NOT NULL,
  profile_data JSONB NOT NULL DEFAULT '{}',
  created_at   TIMESTAMPTZ DEFAULT NOW(),
  updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- TABLE: claims
-- Tracks each user's claim progress for each benefit
-- ============================================================
CREATE TABLE IF NOT EXISTS claims (
  id               UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id          UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  benefit_id       TEXT NOT NULL,
  status           TEXT DEFAULT 'in-progress' CHECK (status IN ('in-progress','submitted','approved')),
  completed_steps  INTEGER[] DEFAULT '{}',
  notes            TEXT,
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, benefit_id)
);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- This ensures each user can ONLY see their own data
-- ============================================================

-- Enable RLS on both tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE claims   ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view their own profile"
  ON profiles FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile"
  ON profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile"
  ON profiles FOR UPDATE USING (auth.uid() = user_id);

-- Claims policies
CREATE POLICY "Users can view their own claims"
  ON claims FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own claims"
  ON claims FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own claims"
  ON claims FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own claims"
  ON claims FOR DELETE USING (auth.uid() = user_id);

-- ============================================================
-- AUTO-UPDATE timestamps
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER claims_updated_at
  BEFORE UPDATE ON claims
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- DONE! Your database is ready.
-- Next step: copy your Supabase URL and Anon Key into index.html
-- ============================================================
