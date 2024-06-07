import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String supabaseUrl = 'https://tiqhorupqwiyiibwcmgl.supabase.co';
final String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRpcWhvcnVwcXdpeWlpYndjbWdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0MTMyMjcsImV4cCI6MjAzMjk4OTIyN30.c_WO8r9ojbKDmDffw3F5pZUR4utoM5vu6KBJTl3yjhQ';
final supabase = SupabaseClient(supabaseUrl, supabaseKey);
