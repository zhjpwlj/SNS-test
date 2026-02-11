-- Storage policies template
-- Assumes two buckets: media-public and media-private

-- Public bucket: read for everyone, write for authenticated owner paths
create policy "public_read_media_public"
on storage.objects for select
using (bucket_id = 'media-public');

create policy "auth_insert_media_public"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'media-public'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "owner_update_media_public"
on storage.objects for update
to authenticated
using (
  bucket_id = 'media-public'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "owner_delete_media_public"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'media-public'
  and (storage.foldername(name))[1] = auth.uid()::text
);

-- Private bucket: owner only
create policy "owner_read_media_private"
on storage.objects for select
to authenticated
using (
  bucket_id = 'media-private'
  and (storage.foldername(name))[1] = auth.uid()::text
);
