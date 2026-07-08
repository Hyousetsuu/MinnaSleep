-- Users (managed by Supabase Auth, extended here)
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  username TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  avatar_url TEXT,
  bio TEXT,
  role TEXT DEFAULT 'free',
  sleep_goal INTEGER DEFAULT 480,         -- in minutes (default 8h)
  bedtime_goal TIME DEFAULT '23:00',
  wakeup_goal TIME DEFAULT '07:00',
  timezone TEXT DEFAULT 'Asia/Jakarta',
  current_streak INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  level INTEGER DEFAULT 1,
  xp INTEGER DEFAULT 0,
  privacy TEXT DEFAULT 'public',          -- public | friends | private
  notifications_enabled BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.sleep_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  bedtime TIMESTAMPTZ NOT NULL,
  wake_time TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER NOT NULL,
  sleep_score INTEGER,                    -- 0-100
  mood TEXT,                              -- emoji or enum
  energy_level INTEGER,                   -- 1-5
  stress_level INTEGER,                   -- 1-5
  notes TEXT,
  tags TEXT[],                            -- array of tags
  source TEXT DEFAULT 'manual',           -- manual | auto
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  plan TEXT NOT NULL,
  billing_cycle TEXT NOT NULL,
  status TEXT DEFAULT 'active',
  started_at TIMESTAMPTZ DEFAULT NOW(),
  expired_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  subscription_id UUID REFERENCES public.subscriptions(id),
  transaction_id TEXT UNIQUE,
  payment_method TEXT,
  amount DECIMAL(12,2) NOT NULL,
  currency TEXT DEFAULT 'IDR',
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_profiles_username ON public.profiles(username);
CREATE INDEX idx_profiles_user_id ON public.profiles(user_id);
CREATE INDEX idx_sleep_sessions_user_id ON public.sleep_sessions(user_id);
CREATE INDEX idx_sleep_sessions_bedtime ON public.sleep_sessions(bedtime);
CREATE INDEX idx_subscriptions_user_id ON public.subscriptions(user_id);
CREATE INDEX idx_payments_user_id ON public.payments(user_id);

-- RLS Policies
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "own_profile_select" ON public.profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "own_profile_insert" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "own_profile_update" ON public.profiles FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "own_sleep_select" ON public.sleep_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "own_sleep_insert" ON public.sleep_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "own_sleep_update" ON public.sleep_sessions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "own_sleep_delete" ON public.sleep_sessions FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "own_sub_select" ON public.subscriptions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "own_pay_select" ON public.payments FOR SELECT USING (auth.uid() = user_id);
