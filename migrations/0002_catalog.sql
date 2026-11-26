create table if not exists store_settings (
  id int primary key default 1 check (id = 1),
  owner_user_id text,
  momo_number text not null default '',
  momo_name text not null default '',
  whatsapp_number text not null default ''
);

insert into store_settings (id)
values (1)
on conflict (id) do nothing;

create table if not exists categories (
  id serial primary key,
  name text not null,
  parent_id int references categories (id) on delete restrict
);

create unique index if not exists categories_root_name
  on categories (lower(name))
  where parent_id is null;

create unique index if not exists categories_child_name
  on categories (parent_id, lower(name))
  where parent_id is not null;

create table if not exists products (
  id serial primary key,
  name text not null,
  price numeric not null,
  description text not null default '',
  category_id int not null references categories (id) on delete restrict,
  image_url text not null default '',
  gallery text not null default '',
  videos text not null default '',
  created_at timestamptz not null default now()
);
