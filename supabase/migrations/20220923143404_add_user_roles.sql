drop policy "Enable read access for all users" on "public"."friends";

create table "public"."roles" (
    "id" bigint generated by default as identity not null,
    "name" text not null
);


alter table "public"."roles" enable row level security;

create table "public"."user_roles" (
    "user_id" uuid not null,
    "role_id" bigint not null
);


alter table "public"."user_roles" enable row level security;

CREATE UNIQUE INDEX roles_name_key ON public.roles USING btree (name);

CREATE UNIQUE INDEX roles_pkey ON public.roles USING btree (id);

CREATE UNIQUE INDEX user_roles_user_id_role_id_key ON public.user_roles USING btree (user_id, role_id);

alter table "public"."roles" add constraint "roles_pkey" PRIMARY KEY using index "roles_pkey";

alter table "public"."roles" add constraint "roles_name_key" UNIQUE using index "roles_name_key";

alter table "public"."user_roles" add constraint "user_roles_role_id_fkey" FOREIGN KEY (role_id) REFERENCES roles(id) not valid;

alter table "public"."user_roles" validate constraint "user_roles_role_id_fkey";

alter table "public"."user_roles" add constraint "user_roles_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."user_roles" validate constraint "user_roles_user_id_fkey";

alter table "public"."user_roles" add constraint "user_roles_user_id_role_id_key" UNIQUE using index "user_roles_user_id_role_id_key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fnc__is_admin(uid uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
AS $function$
select exists
           (select 1
            from user_roles ur
                     left join roles r on r.id = ur.role_id
            where ur.user_id = uid
              and r.name = 'admin')
$function$
;

CREATE OR REPLACE PROCEDURE public.seed_data()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    insert into roles (name) values ('admin') on conflict do nothing;
    
    insert into categories (name)
    values ('ice cream'),
           ('beverage') on conflict do nothing;

    with existing_beverage_id as (select id from categories where name = 'beverage'),
         serving_styles_for_beverage as (select unnest(array ['can', 'bottle', 'carton', 'tap']) name)
    insert
    into serving_styles (name, category_id)
    select ssb.name, ex.id category_id
    from existing_beverage_id ex
             cross join serving_styles_for_beverage ssb
    on conflict do nothing;

    with existing_ice_cream_id as (select id from categories where name = 'ice cream'),
         serving_styles_for_ice_cream as (select unnest(array ['can', 'stick', 'cone', 'cake']) name)
    insert
    into serving_styles (name, category_id)
    select ssb.name, ex.id category_id
    from existing_ice_cream_id ex
             cross join serving_styles_for_ice_cream ssb
    on conflict do nothing;

    insert into flavors (name)
    values ('corn'),
           ('cucumber'),
           ('horseradish'),
           ('vegetable'),
           ('potato'),
           ('tomato'),
           ('caraway'),
           ('clove'),
           ('fennel'),
           ('herbaceous'),
           ('sage'),
           ('butter'),
           ('cheese'),
           ('creamy'),
           ('oily'),
           ('fatty'),
           ('sour'),
           ('coumarin'),
           ('spicy'),
           ('blossom'),
           ('carnation'),
           ('gardenia'),
           ('jasmine'),
           ('lavender'),
           ('lily'),
           ('marigold'),
           ('floral'),
           ('rose'),
           ('violet'),
           ('anise'),
           ('balsam'),
           ('butterscotch'),
           ('caramel'),
           ('chocolate'),
           ('cinnamon'),
           ('honey'),
           ('others'),
           ('sweet'),
           ('vanilla'),
           ('lemon'),
           ('lime'),
           ('melon'),
           ('orange'),
           ('citrus'),
           ('cedar'),
           ('maple'),
           ('mesquite'),
           ('woody'),
           ('bacon'),
           ('beef'),
           ('meaty'),
           ('leafy'),
           ('green'),
           ('wintergreen'),
           ('beer'),
           ('brandy'),
           ('wine like'),
           ('rum'),
           ('whiskey'),
           ('mushroom'),
           ('musty'),
           ('earthy'),
           ('apple'),
           ('apricot'),
           ('banana'),
           ('berry'),
           ('cantaloupe'),
           ('cherry'),
           ('coconut'),
           ('cranberry'),
           ('grape'),
           ('grapefruit'),
           ('jam'),
           ('mango'),
           ('fruity'),
           ('papaya'),
           ('peach'),
           ('pear'),
           ('pineapple'),
           ('plum'),
           ('quince'),
           ('raspberry'),
           ('strawberry'),
           ('tart'),
           ('tropica'),
           ('watermelon'),
           ('alcohol'),
           ('plastic'),
           ('sulfurous'),
           ('almond'),
           ('hazelnut'),
           ('nutty'),
           ('peanut'),
           ('walnut'),
           ('camphoraceous'),
           ('tobacco'),
           ('minty'),
           ('pepper'),
           ('medicinal'),
           ('mossy'),
           ('fishy'),
           ('smoky'),
           ('musky'),
           ('soapy'),
           ('seedy'),
           ('animal'),
           ('alkaline'),
           ('alkane'),
           ('almond shell'),
           ('amine'),
           ('apple peel'),
           ('baked'),
           ('balsamic'),
           ('basil'),
           ('beet'),
           ('biscuit'),
           ('bitter'),
           ('bitter almond'),
           ('black currant'),
           ('boiled vegetable'),
           ('box tree'),
           ('bread'),
           ('broccoli'),
           ('brown sugar'),
           ('burnt'),
           ('burnt sugar'),
           ('cabbage'),
           ('camomile'),
           ('camphor'),
           ('cardboard'),
           ('carrot'),
           ('cat'),
           ('chemical'),
           ('cocoa'),
           ('coffee'),
           ('cognac'),
           ('cologne'),
           ('cooked meat'),
           ('cooked potato'),
           ('cooked vegetable'),
           ('coriander'),
           ('cotton candy'),
           ('cream'),
           ('crushed bug'),
           ('curry'),
           ('dill'),
           ('dust'),
           ('earth'),
           ('ester'),
           ('ether'),
           ('fat'),
           ('fecal'),
           ('fish'),
           ('flower'),
           ('foxy'),
           ('fresh'),
           ('fried'),
           ('fruit'),
           ('garlic'),
           ('gasoline'),
           ('grass'),
           ('green bean'),
           ('green leaf'),
           ('green pepper'),
           ('green tea'),
           ('herb'),
           ('hot milk'),
           ('hummus'),
           ('lactone'),
           ('leaf'),
           ('lettuce'),
           ('licorice'),
           ('lilac'),
           ('magnolia'),
           ('malt'),
           ('mandarin'),
           ('marshmallow'),
           ('meat'),
           ('meat broth'),
           ('medicine'),
           ('menthol'),
           ('metal'),
           ('mildew'),
           ('mint'),
           ('mold'),
           ('moss'),
           ('mothball'),
           ('muguet'),
           ('must'),
           ('mustard'),
           ('nut'),
           ('nutmeg'),
           ('oil'),
           ('onion'),
           ('orange peel'),
           ('orris'),
           ('paint'),
           ('paper'),
           ('pea'),
           ('peanut butter'),
           ('peppermint'),
           ('pesticide'),
           ('phenol'),
           ('pine'),
           ('popcorn'),
           ('prune'),
           ('pungent'),
           ('putrid'),
           ('rancid'),
           ('resin'),
           ('roast'),
           ('roast beef'),
           ('roasted meat'),
           ('roasted nut'),
           ('rubber'),
           ('seaweed'),
           ('sharp'),
           ('smoke'),
           ('soap'),
           ('solvent'),
           ('soy'),
           ('spearmint'),
           ('spice'),
           ('straw'),
           ('sulfur'),
           ('sweat'),
           ('tallow'),
           ('tar'),
           ('tart lime'),
           ('tea'),
           ('terpentine'),
           ('thiamin'),
           ('thyme'),
           ('tomato leaf'),
           ('truffle'),
           ('turpentine'),
           ('urine'),
           ('vinyl'),
           ('warm'),
           ('wax'),
           ('weak spice'),
           ('wet cloth'),
           ('wine'),
           ('wood'),
           ('yeast'),
           ('acid'),
           ('4-t-butyl cyclohexyl acetate'),
           ('absinthe'),
           ('absolute'),
           ('acacia'),
           ('acetate'),
           ('acetic'),
           ('acetoin'),
           ('acetone'),
           ('acetophenone'),
           ('acidic'),
           ('acorn'),
           ('acrid'),
           ('acrylate'),
           ('acrylic'),
           ('adoxal'),
           ('air marine'),
           ('alcoholic'),
           ('aldehyde'),
           ('aldehydic'),
           ('algae'),
           ('alliaceous'),
           ('allo-ocimenol'),
           ('allspice'),
           ('almost odorless'),
           ('amber'),
           ('ambergris'),
           ('ambrette'),
           ('ambrette seed'),
           ('ambrette seed effect'),
           ('ammonia'),
           ('ammoniacal'),
           ('amyl butyl ester'),
           ('amyris'),
           ('angelic'),
           ('angelica'),
           ('aniseed'),
           ('anisic'),
           ('anisyl acetate'),
           ('apple juice'),
           ('apple skin'),
           ('armoise'),
           ('aromatic'),
           ('arrack'),
           ('artichoke'),
           ('asprin'),
           ('astringent'),
           ('autumn'),
           ('azalea'),
           ('banana peel'),
           ('banana skin'),
           ('bark'),
           ('barley'),
           ('bay oil'),
           ('bean'),
           ('beany'),
           ('beef gravey'),
           ('beef juice'),
           ('beefy'),
           ('beeswax'),
           ('bell'),
           ('benzaldehyde'),
           ('benzophenone'),
           ('benzyl acetate'),
           ('benzyl propionate'),
           ('bergamot'),
           ('bilberry'),
           ('bisabolene'),
           ('black tea'),
           ('blackberry'),
           ('blackcurrant'),
           ('bland'),
           ('bloody'),
           ('bloomy'),
           ('blue cheese'),
           ('bluebell'),
           ('blueberry'),
           ('boiled beef'),
           ('boiled egg'),
           ('boiled meat'),
           ('boiled shrimp'),
           ('bois de rose'),
           ('bourbon'),
           ('brassylate'),
           ('bread crust'),
           ('bready'),
           ('broom'),
           ('broth'),
           ('brothy'),
           ('brown'),
           ('brussel sprouts'),
           ('buchu'),
           ('burnt almonds'),
           ('buttered'),
           ('buttermilk'),
           ('buttery'),
           ('butyrate'),
           ('butyric'),
           ('cacao'),
           ('caco'),
           ('cadaverous'),
           ('cake'),
           ('camphoreous'),
           ('cananga'),
           ('candy'),
           ('cantaloupe rind'),
           ('capers'),
           ('caramellic'),
           ('carao'),
           ('cardamom'),
           ('carvone'),
           ('cashew'),
           ('casky'),
           ('cassia'),
           ('cassie'),
           ('cassis'),
           ('castoreum'),
           ('cat-urine'),
           ('catty'),
           ('cauliflower'),
           ('cayloxol'),
           ('cedarleaf'),
           ('cedarwood'),
           ('celery seed'),
           ('cereal'),
           ('chamomile'),
           ('cheesy'),
           ('cherry-pit'),
           ('chicken'),
           ('chicken coop'),
           ('chip'),
           ('chlorine'),
           ('cigar box'),
           ('cinnamate'),
           ('cinnamic'),
           ('cinnamyl'),
           ('cistus'),
           ('citral'),
           ('citralva'),
           ('citric'),
           ('citronella'),
           ('citronellol'),
           ('citronellyl acetate'),
           ('citrus peel'),
           ('civet'),
           ('clam'),
           ('clary'),
           ('clean'),
           ('clean cloth'),
           ('clean clothes'),
           ('clean cloths'),
           ('clover'),
           ('concord grape'),
           ('cooked'),
           ('cooked beef juice'),
           ('cookies'),
           ('cool'),
           ('cooling'),
           ('cortex'),
           ('costus'),
           ('cotton'),
           ('coumarinic'),
           ('crab'),
           ('creosote'),
           ('cresol'),
           ('crispy'),
           ('cucumber seed'),
           ('cucumber skin'),
           ('cultured dairy'),
           ('cumin'),
           ('cuminic acetate'),
           ('cuminseed'),
           ('custard'),
           ('cut grass'),
           ('cut privet'),
           ('cyclamen'),
           ('cypress'),
           ('dairy'),
           ('damp'),
           ('dank'),
           ('dark'),
           ('date'),
           ('deep'),
           ('delicate'),
           ('dewy'),
           ('dirt'),
           ('dirty'),
           ('diterpene'),
           ('dried berry'),
           ('dried fruit'),
           ('dried raspberry'),
           ('dry'),
           ('durian'),
           ('dusty'),
           ('egg'),
           ('elderflower'),
           ('elemi'),
           ('estery'),
           ('ethereal'),
           ('ethyl benzoate'),
           ('ethyl safranate'),
           ('eucalyptus'),
           ('eugenol'),
           ('everlasting'),
           ('extremely sweet'),
           ('faint'),
           ('farnesol'),
           ('feet'),
           ('fenchyl'),
           ('fenugreek'),
           ('fermented'),
           ('fern'),
           ('feta cheese'),
           ('fig'),
           ('filbert'),
           ('fine'),
           ('fir'),
           ('fir needle'),
           ('flat'),
           ('fleafy'),
           ('fleshy'),
           ('flower shop'),
           ('foliage'),
           ('forest'),
           ('fragrant'),
           ('freesia'),
           ('fresh air'),
           ('fresh outdoors'),
           ('freshly plowed soil'),
           ('fungal'),
           ('furfural'),
           ('fusel'),
           ('galbanum'),
           ('gassy'),
           ('genet'),
           ('genista'),
           ('genuine'),
           ('gin'),
           ('ginger'),
           ('ginger root oil'),
           ('glue'),
           ('gooseberry'),
           ('grain'),
           ('grape skin'),
           ('grapefruit peel'),
           ('grapefruit skin'),
           ('grassy'),
           ('gravy'),
           ('greasy'),
           ('green onions'),
           ('grilled'),
           ('grocery store'),
           ('ground'),
           ('guaiacol'),
           ('guaiacwood'),
           ('hairy'),
           ('ham'),
           ('hard yolk'),
           ('harsh'),
           ('hawthorn'),
           ('hay'),
           ('heather'),
           ('heavy'),
           ('heliotrope'),
           ('heliotropin'),
           ('herbal'),
           ('honeydew'),
           ('honeysuckle'),
           ('hot'),
           ('humus'),
           ('hydroxycitronellal'),
           ('iactonic'),
           ('immortelle'),
           ('incense'),
           ('indole'),
           ('intense'),
           ('intensely'),
           ('iodine'),
           ('irone'),
           ('jam preserves'),
           ('jammy'),
           ('jasmin'),
           ('juicy'),
           ('juniper'),
           ('juniper berry'),
           ('ketone'),
           ('ketonic'),
           ('kiwi'),
           ('lactonic'),
           ('lamb'),
           ('lard'),
           ('laundry'),
           ('lavandin'),
           ('leather'),
           ('leathery'),
           ('leaves'),
           ('leek'),
           ('lemon peel'),
           ('lemon rind'),
           ('lemongrass'),
           ('light'),
           ('lily of the valley'),
           ('lime blossom'),
           ('linden'),
           ('linen'),
           ('linseed'),
           ('liquor'),
           ('logenberry'),
           ('lovage'),
           ('low'),
           ('lychee'),
           ('mace'),
           ('macrocyclic'),
           ('mahogany'),
           ('mallow'),
           ('maltol'),
           ('malty'),
           ('mandarin skin'),
           ('maple syrup'),
           ('marine'),
           ('matches'),
           ('may blossom'),
           ('meadow'),
           ('medical'),
           ('mellow'),
           ('melon rind'),
           ('mentholic'),
           ('mercaptan'),
           ('metallic'),
           ('mignonette'),
           ('mild'),
           ('milk'),
           ('milky'),
           ('mimosa'),
           ('moist'),
           ('molasses'),
           ('moldy'),
           ('moscato'),
           ('moth ball'),
           ('mouldy'),
           ('mousy'),
           ('musk'),
           ('mutton'),
           ('narcissus'),
           ('nasturtium'),
           ('natural'),
           ('neroli'),
           ('new car'),
           ('new mown hay'),
           ('niobe'),
           ('nitrile'),
           ('nut skin'),
           ('oak'),
           ('odorless'),
           ('old paper'),
           ('old wood'),
           ('orange blossom'),
           ('orange flower'),
           ('orange juice'),
           ('orchid'),
           ('oriental'),
           ('outdoor'),
           ('overripe fruit'),
           ('oxyacetaldehyde'),
           ('ozone'),
           ('painty'),
           ('palmarosa'),
           ('parmesan'),
           ('parsley'),
           ('passion fruit'),
           ('pastry'),
           ('patchouli'),
           ('peach-pit'),
           ('pear skin'),
           ('peely'),
           ('pencil'),
           ('penetrating'),
           ('peony'),
           ('peppery'),
           ('peptone'),
           ('petal'),
           ('petitgrain'),
           ('petroleum'),
           ('phenolic'),
           ('pine needle'),
           ('pistachio'),
           ('plant'),
           ('pleasant'),
           ('plum skin'),
           ('pollen'),
           ('pork'),
           ('powderful'),
           ('powdery'),
           ('powerful'),
           ('privet'),
           ('privet blossom'),
           ('profarnesal'),
           ('propionic'),
           ('pulpy'),
           ('pumpkin'),
           ('pyridine'),
           ('radiant'),
           ('radish'),
           ('raisin'),
           ('raw'),
           ('red cedar'),
           ('red fruit'),
           ('red hots'),
           ('red rose'),
           ('repulsive'),
           ('reseda'),
           ('resinous'),
           ('rhubarb'),
           ('rich'),
           ('ricotta'),
           ('ripe'),
           ('ripe apricot'),
           ('roasted'),
           ('roasted almonds'),
           ('roasted in sugar syrup'),
           ('roasted nuts'),
           ('roasted peanut'),
           ('roasted peanuts'),
           ('romano'),
           ('root'),
           ('rootbeer'),
           ('rooty'),
           ('roquefort cheese'),
           ('rose acetate'),
           ('rose bud'),
           ('rose de mai'),
           ('rose dried'),
           ('rose flower'),
           ('rose petals'),
           ('rose water'),
           ('rosemary'),
           ('rosy'),
           ('rotten'),
           ('rotting'),
           ('rubbery'),
           ('rue'),
           ('rummy'),
           ('rye'),
           ('saffron'),
           ('salmon'),
           ('salt'),
           ('sandy'),
           ('savory'),
           ('sawdust'),
           ('scallion'),
           ('sea'),
           ('seafood'),
           ('shellfish'),
           ('shrimp'),
           ('sickening'),
           ('skunky'),
           ('slight'),
           ('slightly fruity'),
           ('slightly metallic'),
           ('slightly roasted nut'),
           ('slightly rose'),
           ('slightly waxy'),
           ('smoked'),
           ('soft'),
           ('soil'),
           ('soup'),
           ('soupy'),
           ('soybean'),
           ('spring'),
           ('stem'),
           ('stinky'),
           ('storax'),
           ('strong'),
           ('styrene'),
           ('sugar'),
           ('sulfide'),
           ('sulfury'),
           ('sweaty'),
           ('sweet corn'),
           ('syrup'),
           ('taco'),
           ('tagette'),
           ('tangerine'),
           ('tangy'),
           ('tarragon'),
           ('tarry'),
           ('terpene'),
           ('terpenic'),
           ('terpineol'),
           ('thiamine'),
           ('thuja'),
           ('thujone'),
           ('thymol'),
           ('toasted'),
           ('tobacco-leaf'),
           ('toffee'),
           ('toluene'),
           ('tonka'),
           ('tree'),
           ('tropical'),
           ('tropical fruit'),
           ('tuberose'),
           ('turnup'),
           ('tutti frutti'),
           ('umami'),
           ('unpleasant'),
           ('unripe banana'),
           ('unripe fruit'),
           ('unripe plum'),
           ('valerian'),
           ('vanillin'),
           ('velvety'),
           ('very faint'),
           ('very intense'),
           ('very mild'),
           ('very slight'),
           ('very strong'),
           ('very sweet'),
           ('vetiver'),
           ('weak'),
           ('weedy'),
           ('wet'),
           ('wild'),
           ('wine-lee'),
           ('winey'),
           ('yeasty')
    on conflict do nothing;
END
$procedure$
;

create policy "Enable delete for users based on creator"
on "public"."check_ins"
as permissive
for delete
to public
using ((auth.uid() = created_by));


create policy "Enable update for own check-ins"
on "public"."check_ins"
as permissive
for update
to public
using ((created_by = auth.uid()));


create policy "Enable delete for both sides of friend status"
on "public"."friends"
as permissive
for delete
to public
using (((user_id_1 = auth.uid()) OR (user_id_2 = auth.uid())));


create policy "Enable insert for authenticated users only"
on "public"."friends"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for non-blocked users"
on "public"."friends"
as permissive
for select
to public
using (((status <> 'blocked'::friend_status) OR (blocked_by = auth.uid())));


create policy "Enable update for both sides of friend status unless blocked"
on "public"."friends"
as permissive
for update
to public
using ((((user_id_1 = auth.uid()) AND (blocked_by <> auth.uid())) OR ((user_id_2 = auth.uid()) AND (blocked_by <> auth.uid()))));


